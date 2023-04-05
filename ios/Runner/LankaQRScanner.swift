//
//  LankaQRScanner.swift
//  Runner
//
//  Created by Developer on 2022-01-26.
//

import Foundation
import LankaQRUtilSDK
import MPQRCoreSDK

class LankaQRScanner {
    
    static func getLankaQRData(qrString: String) -> String {
        do {
            let lankaQRReader = LankaQRReader()
            var lankaQRPayload = LankaQRPayload()
            var additionalData = AdditionalData()
            lankaQRReader.setLogging(logRequired: false)
            
            let pushData = try lankaQRReader.parseQR(qrString: qrString)
            print(pushData?.dumpData())
            
            var qrMAIData = ""
            
            do {
                qrMAIData = try pushData?.getMAIData(forTagString: "26").AID as! String
            } catch {
                qrMAIData = try pushData?.getMAIData(forTagString: "27").AID as! String
            }
            
            qrMAIData += pushData?.merchantName ?? ""
            
            additionalData = pushData?.additionalData ?? AdditionalData()
            
            if qrMAIData.isEmpty {
                return "ERROR"
            } else {
                return qrMAIData
            }
            
        } catch {
            return "ERROR"
        }
    }
    
    
}
