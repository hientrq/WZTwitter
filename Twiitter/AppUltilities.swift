//
//  AppUltilities.swift
//  Twiitter
//
//  Created by Hien Quang Tran on 9/29/16.
//  Copyright © 2016 Hien Tran. All rights reserved.
//

import Foundation

public enum DateStringFormat : String {
    case EEE_MMM_d_HH_mm_ss_Z_yyyy = "EEE MMM d HH:mm:ss Z y"
    case EEE_DD_MMM_YYYY_HH_mm = "EEE, dd MMM yyyy, HH:mm"
}

func getStringFromDate(_ date: Date, withFormat format: DateStringFormat) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    return formatter.string(from: date)
}

func getDateFromString(_ string: String, withFormat format: DateStringFormat) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    
    if let date = formatter.date(from: string) {
        return date
    } else {
        return nil
    }
}
