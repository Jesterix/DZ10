//
//  MeasureRegex.swift
//  DZ10
//
//  Created by Georgy Khaydenko on 08/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import Foundation

struct MeasureRegex {
    let measureRegexKm = #"(km|kilometers|kilometer|км|километров|километра|километр)"#
    let measureRegexM = #"(m|meters|meter|метров|метра|метр|м)"#
    let measureRegexCm = #"(cm|centimeters|centimeter|см|сантиметров|сантиметра|сантиметр)"#
    let measureRegexMm = #"(mm|millimeters|millimeter|мм|миллиметров|миллиметра|миллиметр)"#
    let measureRegexMcm = #"(μm|micrometers|micrometer|мкм|микрометров|микрометра|микрометр)"#
    let measureRegexMile = #"(miles|mile|mi|миль|миля|мили)"#
    let measureRegexNauticalMile = #"(NM|nmi|nautical miles|nautical mile|морских миль|морская миля|морских мили)"#
    let measureRegexFurlong = #"(furlongs|furlong|fur|фурлонгов|фурлонга|фурлонг)"#
    let measureRegexInch = #"(inches|inch|in|дюймов|дюйма|дюйм)"#
    let measureRegexFoot = #"(feet|foot|ft|футов|фута|фут)"#
    let measureRegexYard = #"(yards|yard|yd|ярдов|ярда|ярд)"#
    let measureRegexScandinavianMiles = #"(scandinavian miles|scandinavian mile|smi|скандинавских миль|скандинавских мили|скандинавская миля)"#
    let measureRegexFathoms = #"(fanthoms|fanthom|ftm|фантомов|фантома|фантом)"#
    
    let measureRegexNumbers = #"([0-9]{1,3}? ?)*[0-9]{1,3}[.,]?[0-9]* ?"#
    
    func createRegexArray() -> [(String, UnitLength)]{
        var array: [(String, UnitLength)] = []
        array.append((self.measureRegexCm, UnitLength.centimeters))
        array.append((self.measureRegexKm, UnitLength.kilometers))
        array.append((self.measureRegexM, UnitLength.meters))
        array.append((self.measureRegexMm, UnitLength.millimeters))
        array.append((self.measureRegexMcm, UnitLength.micrometers))
        array.append((self.measureRegexMile, UnitLength.miles))
        array.append((self.measureRegexNauticalMile, UnitLength.nauticalMiles))
        array.append((self.measureRegexFurlong, UnitLength.furlongs))
        array.append((self.measureRegexInch, UnitLength.inches))
        array.append((self.measureRegexFoot, UnitLength.feet))
        array.append((self.measureRegexYard, UnitLength.yards))
        array.append((self.measureRegexScandinavianMiles, UnitLength.scandinavianMiles))
        array.append((self.measureRegexFathoms, UnitLength.fathoms))
        
        return(array.map { (self.measureRegexNumbers + $0.0, $0.1)})
    }
}
