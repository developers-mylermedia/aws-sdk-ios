//
//  DeviceOperations.swift
//  AWSMobileClient
//

import Foundation
import AWSCognitoIdentityProvider_MylerFork

/// DeviceOperations is responsible for handling mobile device related operations for logged in user.
public class DeviceOperations {
    
    weak var mobileClient: AWSMobileClient?
    
    internal static let sharedInstance: DeviceOperations = DeviceOperations()
    
    
    /// List all devices for current user.
    ///
    /// - Parameters:
    ///   - limit: The number of devices to list in current call. Defaults to 60(max possible value)
    ///   - paginationToken: The pagination token returned in previous list call to get more devices.
    ///   - completionHandler: completion handler for result or error.
    public func list(limit: Int = 60, paginationToken: String? = nil, completionHandler: @escaping ((ListDevicesResult?, Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                let message = AWSMobileClientConstants.notSignedInMessage
                let error = AWSMobileClientError.notSignedIn(message: message)
                completionHandler(nil, error)
                return
            }
            currentActiveUser.listDevices(Int32(limit), paginationToken: paginationToken).continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(nil, AWSMobileClientError.makeMobileClientError(from: error))
                } else if let result = task.result {
                    var devices: [Device] = []
                    if result.devices != nil {
                        for device in result.devices! {
                            devices.append(self.getMCDeviceForCognitoDevice(device: device))
                        }
                    }

                    let listResult = ListDevicesResult(devices: devices, paginationToken: result.paginationToken)
                    completionHandler(listResult, nil)
                }
                return nil
            }

        }

    }
    
    
    /// Update status for specified device id.
    ///
    /// - Parameters:
    ///   - deviceId: the device id which needs to be updated.
    ///   - remembered: true if device has to be remembered. false to set it to not remembered.
    ///   - completionHandler: completion handler for result or error.
    public func updateStatus(deviceId: String, remembered: Bool, completionHandler: @escaping ((UpdateDeviceStatusResult?, Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                let message = AWSMobileClientConstants.notSignedInMessage
                let error = AWSMobileClientError.notSignedIn(message: message)
                completionHandler(nil, error)
                return
            }
            currentActiveUser.updateDeviceStatus(deviceId, remembered: remembered).continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(nil, AWSMobileClientError.makeMobileClientError(from: error))
                } else if let _ = task.result {
                    completionHandler(UpdateDeviceStatusResult(), nil)
                }
                return nil
            }
        }
    }
    
    /// Update status for current device.
    ///
    /// - Parameters:
    ///   - remembered: true if device has to be remembered. false to set it to not remembered.
    ///   - completionHandler: completion handler for result or error.
    public func updateStatus(remembered: Bool, completionHandler: @escaping ((UpdateDeviceStatusResult?, Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                let message = AWSMobileClientConstants.notSignedInMessage
                let error = AWSMobileClientError.notSignedIn(message: message)
                completionHandler(nil, error)
                return
            }
            currentActiveUser.updateDeviceStatus(remembered).continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(nil, AWSMobileClientError.makeMobileClientError(from: error))
                } else if let _ = task.result {
                    completionHandler(UpdateDeviceStatusResult(), nil)
                }
                return nil
            }
        }
    }
    
    
    /// Get details for specified device id.
    ///
    /// - Parameters:
    ///   - deviceId: deviceId for device whose details need to be fetched.
    ///   - completionHandler: completion handler for result or error.
    public func get(deviceId: String, completionHandler: @escaping ((Device?, Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                let message = AWSMobileClientConstants.notSignedInMessage
                let error = AWSMobileClientError.notSignedIn(message: message)
                completionHandler(nil, error)
                return
            }
            currentActiveUser.getDevice(deviceId).continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(nil, AWSMobileClientError.makeMobileClientError(from: error))
                } else if let result = task.result {
                    completionHandler(self.getMCDeviceForCognitoDevice(device: result.device), nil)
                }
                return nil
            }
        }
    }
    
    
    /// Get details of current device.
    ///
    /// - Parameter completionHandler: completion handler for result or error.
    public func get(_ completionHandler: @escaping ((Device?, Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                let message = AWSMobileClientConstants.notSignedInMessage
                let error = AWSMobileClientError.notSignedIn(message: message)
                completionHandler(nil, error)
                return
            }
            currentActiveUser.getDevice().continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(nil, AWSMobileClientError.makeMobileClientError(from: error))
                } else if let result = task.result {
                    completionHandler(self.getMCDeviceForCognitoDevice(device: result.device), nil)
                }
                return nil
            }
        }
    }
    
    
    /// Forget specified device.
    ///
    /// - Parameters:
    ///   - deviceId: The deviceId of device which needs to be stopped being tracked.
    ///   - completionHandler: completion handler for result or error.
    public func forget(deviceId: String, completionHandler: @escaping ((Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                let message = AWSMobileClientConstants.notSignedInMessage
                let error = AWSMobileClientError.notSignedIn(message: message)
                completionHandler(error)
                return
            }
            currentActiveUser.forgetDevice(deviceId).continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(AWSMobileClientError.makeMobileClientError(from: error))
                } else if let _ = task.result {
                    completionHandler(nil)
                }
                return nil
            }
        }
    }
    
    
    /// Forget current device. The device will no longer be tracked. Note: Calling `updateStatus` to remember the device after calling forget device will result in error. To remember a forgotten device, the user needs to re-login.
    ///
    /// - Parameter completionHandler: completion handler for result or error.
    public func forget(_ completionHandler: @escaping ((Error?) -> Void)) {
        mobileClient?.getTokens{ _, error in
            if let error = error {
                completionHandler(error)
                return
            }
            guard let currentActiveUser = self.mobileClient?.userpoolOpsHelper?.currentActiveUser else {
                completionHandler(AWSMobileClient.missingCurrentActiveUser())
                return
            }
            currentActiveUser.forgetDevice().continueWith { (task) -> Any? in
                if let error = task.error {
                    completionHandler(AWSMobileClientError.makeMobileClientError(from: error))
                } else if let _ = task.result {
                    completionHandler(nil)
                }
                return nil
            }
        }
    }
    
    internal func getMCDeviceForCognitoDevice(device: AWSCognitoIdentityProviderDeviceType?) -> Device {
        let createDate = device?.deviceCreateDate
        let lastAuthDate = device?.deviceLastAuthenticatedDate
        let lastModifiedDate = device?.deviceLastModifiedDate
        let deviceKey = device?.deviceKey
        var attributes: [String: String] = [:]
        if device?.deviceAttributes != nil {
            for attr in device!.deviceAttributes! {
                if attr.name != nil && attr.value != nil {
                    attributes[attr.name!] = attr.value!
                }
            }
        }
        return Device(attributes: attributes, createDate: createDate, deviceKey: deviceKey, lastAuthenticatedDate: lastAuthDate, lastModifiedDate: lastModifiedDate)
    }
}
