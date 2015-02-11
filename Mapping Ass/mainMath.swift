//
//  mainMath.swift
//  Mapping Ass
//
//  Created by Bernie Suen on 15/1/24.
//  Copyright (c) 2015年 Bernie Suen. All rights reserved.
//

import UIKit

class mainMath
{
    
    func aTr(angle:Double) -> Double
    {
        return angle * M_PI/180.0
        
    }
    
    func sec(radian:Double) -> Double
    {
        return 1.0/(cos(radian))
    }
    
    
    func fromSecond(seacond:Double)->Double
    {
        return (seacond/60.0)/60.0
    }
    
    func fromMins(mins:Double) -> Double
    {
        
        return mins/60.0
    }
    
    func _sin(degress:Double) ->Double
    {
        return sin(aTr(degress))
    }
    
    func qianxianchang(degress:Double, r:Double) ->Double
    {
        let tempDegress = degress/2.0
        var b  = tan(aTr(tempDegress))
        var t =  r * b
        return t
    }
    
    func waishiju(degress:Double, r:Double) -> Double
    {
        let tempDegress = degress/2.0
        var b  = sec(aTr(tempDegress))
        var c = b - 1.0
        return r * c
    }
    
    func quxianchang(degress:Double, r:Double)->Double
    {
        return r * aTr(degress)
    }
    
    func quxianchang_y(degress:Double, r:Double, l0: Double)->Double
    {
        let d = self.aTr(degress)
        let pi = M_PI
        
        return l0 + (r * d)
    }
    
    func _p(r:Double, l0: Double)->Double
    {
        return (l0*l0)/(24 * r)
    }
    
    func waishiju_y(degress: Double, r: Double, l0: Double)->Double
    {
        let p = _p(r,l0: l0)
        let d = sec(self.aTr(degress/2))
        return (r + p) * d - r
    }
    
    func _m(l0:Double, r:Double) -> Double
    {
        return (l0/2) - ((l0*l0*l0)/(240*(r * r)))
    }
    
    func qixianchang_y(degress:Double, r:Double, l0: Double)->Double
    {
        let m = self._m(l0, r: r)
        let p = self._p(r,l0: l0)
        let d = tan(self.aTr(degress/2))
        
        return m + ((r + p) * d)
    }
    func bihechajisuan(qLc: Double, hLc:Double, qBg: Double, hBg: Double, qsh:Double, hsh:Double, standardT:Double = 30.0) -> Bool
    {
        var l = abs(hLc - qLc)
        var bgc = hBg - qBg
        var bhc = (qsh - hsh) - bgc * 1000
        
        var standard = standardT * sqrt(l)
        if abs(bhc) <= standardT
        {
            println("bhc\(bhc)")
            return true
        }
        else   
        {
            println(bhc)
            return false
        }
    }
}
