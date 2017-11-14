//
//  Matrix+float3.swift
//  ARKitPlaying
//
//  Created by AnnGorobchenko on 11/14/17.
//  Copyright © 2017 com.ann. All rights reserved.
//

import Foundation
import ARKit

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
