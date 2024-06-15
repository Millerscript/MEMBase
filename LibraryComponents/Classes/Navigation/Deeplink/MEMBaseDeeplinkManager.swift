//
//  MEMBaseDeeplinkManager.swift
//  MEMBase
//
//  Created by Miller Mosquera on 1/03/24.
//

import Foundation

open class MEMBaseDeeplinkManager {
    
    public static let shared = MEMBaseDeeplinkManager()
    
    struct Constants {
        static let dot: String = "."
        static let backSlash: String = "/"
    }
    
    enum Vias {
        case HOST
        case PATH
        case NONE
    }
    
    private var navigation = MEMBaseNavigationController.shared
    
    private var viewControllers: [String: String] = [:]
    private var viewControllerBundles: Set<[String: String]> = []
    private var viewControllerData: [String: Any] = [:]
    private var allowedHosts: [String] = []
    private var routeHandlers: [[String: MEMBaseRouteHandlerProtocol]] = []
    
    private init() {}
    
    /**
     * Get the way the deeplink is going be execute, for instance: mccommons://creators/ (host), mccommons://creators/profile (path)
     * - parameters host: host from the deeplink if exist
     * - parameters path: path from the deeplink if exist
     * - returns: the type of Via of the action
     */
    private func getVia(host: String, 
                        path: String) -> Vias {
        if !path.isEmpty {
            return .PATH
        } else if !host.isEmpty {
            return .HOST
        } else {
            return .NONE
        }
    }
    
    /**
     * Validate whether the host is valid or path and then search the class name using the deeplink value to open the class
     * - parameters host:
     * - parameters path:
     * - parameters via:
     */
    private func handle(host: String, 
                        path: String,
                        via: Vias) {
        
        let deeplink = (via == .HOST) ? host : path // getPath(deeplink: path)
        
        guard let viewControllerStringName = viewControllers[deeplink] else {return}
        
        navigation.open(path: getFilePath(className: getFileName(fileName: viewControllerStringName)), viewControllerData: self.viewControllerData)
    }
    
    /**
     * Get the last part of the path, for instance mccommons://creators/profile/{edit} <- "edit"
     * - parameters deeplink: the complete link ( mccommons://creators/profile/edit )
     * - returns:the last path of the deeplink
     */
    private func getPath(deeplink: String) -> String {
        return deeplink.components(separatedBy: Constants.backSlash).last ?? ""
    }
    
    @available(*, deprecated, renamed: "getTargetName", message: "out of date, start using getTargetName instead")
    private func getAppName(_ using: String? = "")  -> String {
        
        if let using = using, !using.isEmpty {
            let name = using.components(separatedBy: Constants.dot)
            print(name.last ?? "")
            
            return name.last ?? ""
        } else {
            guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
                return ""
            }
            
            return appName
        }
    }
    
    /**
     * Get the target name using the bundleId wich is gotten with the name of the file
     * param: bundleId, the name of the bundle where the file is located
     * return: the name of the project target
     */
    private func getTargetName(with bundleId: String) -> String {
        return !bundleId.isEmpty ? bundleId.components(separatedBy: Constants.dot).last ?? "" : ""
    }
    
    /**
     *
     */
    private func getBundleId(of className: String) -> String {
        let bundlesId = viewControllerBundles.filter { bundles in
            let result = bundles.filter { $0.key == className }
            return !result.isEmpty
        }
        
        guard let bundleId = bundlesId.first else { return "" }
        guard let value = bundleId.values.first else { return "" }
        
        return value
    }
    
    /**
     * Get the file name without the extension
     * - parameters filename:
     * - returns: String
     */
    private func getFileName(fileName: String) -> String {
        return fileName.components(separatedBy: Constants.dot).first ?? ""
    }
    
    
    /**
     * getFilePath
     * - parameters className:
     * - returns:
     */
    private func getFilePath(className: String) -> String {
        let file = getFileName(fileName: className)
        let path = "\(getTargetName(with: getBundleId(of: file)) ).\(file)"
        print("class name: \(path)")
        return path
    }
    
    /**
     * Register a bundle for the classViewController, using Bundle(for: ).bundleIdentifier it searchs the associated bundle for the class
     * - parameters classViewController :
     * - authors: Mc
     */
    private func registerBundle<T>(Of classViewController: T) {
        var bundleDictionary: [String: String] = [:]
        
        guard let viewController = classViewController.self as? MEMBaseViewController.Type,
              let classBundle = Bundle(for: viewController).bundleIdentifier else {return}

        bundleDictionary[String(describing: viewController.self)] = classBundle
        viewControllerBundles.insert(bundleDictionary)
    }
    
    /**
     *
     * - parameters urlContext:
     * - returns:
     */
    private func getDeeplinkUrl(urlContext: Set<UIOpenURLContext>) -> URL? {
        guard let firstUrl = urlContext.first else { return nil }
        return firstUrl.url
    }
    
    /**
     * - parameters url:
     * - returns:
     */
    private func getComponents(url: URL) -> NSURLComponents? {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        return components
    }
    
    /**
     * - parameters components:
     * - returns:
     */
    private func getHost(components: NSURLComponents) -> String? {
        guard let host = components.host else { return nil }
        return host
    }
    
    
    /**
     * - parameters URLContexts:
     * - authors: Mc
     */
    public func verifyUrl(URLContexts: Set<UIOpenURLContext>, urlD: URL? = nil) {
        
        guard let url = getDeeplinkUrl(urlContext: URLContexts) else { return }
        guard let component = getComponents(url: url) else { return }
        guard let host = getHost(components: component) else { return }
        
        if !allowedHosts.contains(host) { return }

        self.viewControllerData = gatherDataFrom(queryItems: component.queryItems)
        
        handle(host: host, path: component.path ?? .empty, via: getVia(host: host, path: component.path ?? .empty))
    }
    
    /**
     * - parameters URLContexts:
     * - authors: Mc
     */
    public func verifyUrl(url: URL) {        
        guard let component = getComponents(url: url) else { return }
        guard let host = getHost(components: component) else { return }
        
        if !allowedHosts.contains(host) { return }

        self.viewControllerData = gatherDataFrom(queryItems: component.queryItems)
        
        handle(host: host, path: component.path ?? .empty, via: getVia(host: host, path: component.path ?? .empty))
    }
        
    /**
     * Gathering data from url and righ after send to the viewcontroller destination
     * - parameters queryItems : Data wich come from deeplink components
     * - returns : collected data
     * - authors :Mc
     */
    private func gatherDataFrom(queryItems: [URLQueryItem]? ) -> Dictionary<String, Any> {
        var data: [String: Any] = [:]
        
        guard let queryItems = queryItems else { return [:] }
                    
        _ = queryItems
            .filter { $0.value != nil }
            .compactMap { data.updateValue($0.value!, forKey: $0.name) }

        return data
    }
    
    /**
     * Sing up a host with the view controller
     *  - parameter endPoint :
     *  - parameter viewController :
     *  - returns : None
     *  - authors : Mc
     */
    public func register<T>(endPoint: String, viewController: T) {
        registerBundle(Of: viewController)
        viewControllers[endPoint] = String(describing: viewController.self)
    }
    
    /// #Important
    /// this function open the deeplink when it comes from external runs
    /// - parameters deeplink:
    public func open(deepLink: String) {
        guard let validDeeplink = URL(string: deepLink) else { return }
        UIApplication.shared.open(validDeeplink)
    }

    /** Execute every manager that has been passed to the list
     * - parameter list: list of managers passed by the dev
     * - authors: Mc
     */
    public func setHostManagers(list: [String: MEMBaseRouteHandlerProtocol]) {
        list.forEach { item in
            self.allowedHosts.append(item.key)
            item.value.add()
        }
    }
    
}
