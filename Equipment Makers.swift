//
//  Equipment Helpers.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

let Quantity = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]

enum Catagory {
    case camera, primes, macros, probeLens, zoomLens, aks, finder, filters, support
    
    static let allValues = ["Camera", "Primes", "Macros", "Probe Lens", "Zoom Lens", "AKS", "Finder", "Filters", "Support"]
}

enum MakerCamera {
    case arri, red, phantom, panavision, sony
    
    static let allValues = ["Arri", "Red", "Phantom", "Panavision", "Sony"]
}

enum MakerPrimes {
    case zeiss, leica, canon, cooke, panavision, vantage, bauschlomb, kowa, kineoptic, nikkor, red, camtec, anamorphic
    
    static let allValues = ["Zeiss","Leica","Canon","Cooke", "Panavision", "Vantage", "Bausch + Lomb", "Kowa",
                            "Kineoptic", "Nikkor", "Red", "CamTec", "Anamorphic"]
}

enum MakerMacros {
    case arri, zeiss, panavision
    
    static let allValues = ["Arri", "Zeiss", "Panavision"]
}

enum MakerProbe {
    case innovision, tRex, revolution, skater, century, optex, frazier
    
    static let allValues = ["Innovision", "T-Rex", "Revolution", "Skater", "Century", "Optex", "Frazier"]
}

enum MakerZoom {
    case angenieux, fujinon, cooke, zeissVP, hawk, century, canon, anamorphic, panavision
    static let allValues = ["Angenieux","Fujinon", "Cooke","Zeiss VP", "Hawk", "Century", "Canon","Anamorphic", "Panavision"]
}

enum MakerAKSFiltersSupport {
    case selectItems
    
    static let allValues = [""]
}

enum MakerFinder {
    case standard, anamorphic
    static let allValues = ["Standard","Anamorphic"]
}

class Maker {
    var makerCamera: MakerCamera
    var makerPrimes: MakerPrimes
    var makerMacros: MakerMacros
    var makerProbes: MakerProbe
    var makerZoom:   MakerZoom
    var makerAKSFiltersSupport: MakerAKSFiltersSupport
    var makerFinder: MakerFinder
    
    init(makerCamera: MakerCamera, makerPrimes: MakerPrimes, makerMacros: MakerMacros, makerProbes: MakerProbe, makerZoom: MakerZoom, makerAKSFiltersSupport: MakerAKSFiltersSupport, makerFinder: MakerFinder ) {
        self.makerCamera = makerCamera
        self.makerPrimes = makerPrimes
        self.makerMacros = makerMacros
        self.makerProbes = makerProbes
        self.makerZoom = makerZoom
        self.makerAKSFiltersSupport = makerAKSFiltersSupport
        self.makerFinder = makerFinder
    }
}

func setCamModel(maker: MakerCamera) -> [String] {
    switch maker {
    case .arri:
        return ["Mini", "Amira", "Alexa", "Alexa STX", "Alexa XT+","Alexa +XR","Alexa ST XR","Alexa M", "235", "535B", "435", "Arricam LT", "Arricam ST", "SR3", "416"]
    case .red:
        return ["Weapon", "Epic","Epic Dragon","One"]
    case .phantom:
        return ["Flex 4k", "Flex", "HD Gold"]
    case .panavision:
        return ["Genesis", "Millennium DX-L", "XL2", "Platinum", "Millennium", "Gold-G2", "Panaflex LW-2", "65mm"]
    case .sony:
        return ["F-35", "F-55", "F-65", "Cine Alta F-55", "Cine Alta 4k","F-5","F-S5","F-S7"]
    }
}

func setPrimesModel(maker: MakerPrimes) -> [String] {
    switch maker {
    case .zeiss:
        return ["Master Primes", "Ultra Primes", "Super Speeds", "Standard Speeds", "Compact S2"]
    case .leica:
        return ["Summilux-C", "Summicron-C", "Telephoto"]
    case .canon:
        return ["K-35", "Telephoto"]
    case .cooke:
        return ["i5", "S4", "Speed Panchro"]
    case .panavision:
        return ["Primo 70", "Primo V", "P Vintage", "Primo",  "Legacy", "Primo Digital"]
    case .vantage:
        return  ["One"]
    case .bauschlomb:
        return ["Super Baltar"]
    case .kowa:
        return ["Cine Prominar"]
    case .kineoptic:
        return ["Apochromat"]
    case .nikkor:
        return  ["Telephoto"]
    case .red:
        return ["Pro"]
    case .camtec:
        return ["Ultra Primes"]
    case .anamorphic:
        return ["Cooke Vintage", "Cooke", "Master Primes", "Arriscope", "Kowa", "Hawk VL", "Hawk V", "Hawk C", "Cineovision"]
    }
}

func setMacrosModel(maker: MakerMacros) -> [String] {
    switch maker {
    case .arri:
        return ["Macro"]
    case .zeiss:
        return ["Master Primes"]
    case .panavision:
        return ["Panavision"]
    }
}

func setProbeModel(maker: MakerProbe) -> [String] {
    switch maker {
    case .innovision:
        return ["Probe II+"]
    case .tRex:
        return ["Probe"]
    case .revolution:
        return ["Probe"]
    case .skater:
        return ["Scope"]
    case .century:
        return ["Periscope"]
    case .optex:
        return ["Excellence"]
    case .frazier:
        return ["Frazier"]
    }
}

func setZoomModel(maker: MakerZoom)-> [String] {
    switch maker {
    case .angenieux:
        return ["17-102", "16-42 Rouge", "30-80 Rouge", "45-120 Optimo", "28-76 Optimo", "15-40 Optimo","17-80 Optimo", "24-290 Optimo", "25-250 HR"]
    case .fujinon:
        return ["24-180 Premier", "75-400 Premier", "18-85 Premier", "45-250 Alura", "18-80 Alura"]
    case .cooke:
        return ["25-250 Mk2", "20-60", "15-40 CXX", "18-100"]
    case .zeissVP:
        return ["16-30", "29-60", "55-105"]
    case .hawk:
        return ["17-35", "100-300", "150-450"]
    case .century:
        return ["28-70", "17-35", "150-600"]
    case .canon:
        return ["50-1000"]
    case .anamorphic:
        return ["Angenieux 30-72", "Angenieux 56-152","Angenieux 34-204", "Angenieux 50-500",
                "Angenieux 48-580","Cooke 40-120", "Cooke 36-200", "Cooke 40-200","Cooke 50-500"]
    case .panavision:
        return ["Low Ratio 15-40", "Low Ratio 27-75","Low Ratio 60-125","Primo 17.5-75","Primo 19-90","Primo 24-275","Primo 135-420","STZ 70-200mm", "LWZ 27-68", "LWZ 17.5 - 34", "LWZ 85-200", "Z10S 20-250", "Z6S 20-120","Canon 150-600"]
    }
}

func setModelEmpty() -> [String] {
    return [""]
}

func setFinderModel(maker: MakerFinder) -> [String] {
    switch maker {
    case .standard:
        return ["Standard"]
    case .anamorphic:
        return ["Anamorphic"]

    }
}
