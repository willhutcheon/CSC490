//
//  Exercise.swift
//  SpartanFit
//
//  Created by Collin Harris on 10/8/24.
//
//This is nothing ignore it
import Foundation
import SwiftUI
//for each set

enum SetVariation{
    case one
    case alternate
    case maxout
}

enum SetType{
    case regular
    case warmup
    case max
}
class workoutSet :Identifiable{
    @Published var type = SetType.regular
    @Published var weights: Double = 0.0
    @Published var reps_input: Array<Int> = []
    @Published var reps_assumed: Array<Int>
    init(type: SetType, weights: Double = 5.0, reps_assumed: [Int] = [10]) {
        self.type = type
        self.weights = weights
        self.reps_assumed = reps_assumed
        for rep in reps_assumed{
            self.reps_input.append(rep * 0)
        }
    }
}


class Exercise: ObservableObject{
    @Published var name = ""
    @Published var completeness = 0.0
    @Published var set_count:Int
    @Published var sets :Array <workoutSet> = []
    @Published var setvar: SetVariation
    @Published var target: Array <String> = []
    
    init(name:String = "",set_count: Int = 1,regular_weight:Double = 1.0,warm_up_count: Int = 1,warm_up_weight: Double = 5.0 ,setvar: SetVariation) {
        self.set_count = set_count
        self.setvar = setvar
        var i = 0
        while(i < set_count){
            //the 10 is a place holder subject to change
            if i < warm_up_count && setvar == SetVariation.one{
                self.sets.append(workoutSet(type: SetType.warmup,weights: warm_up_weight,reps_assumed: [10]))
            }
            else if i > warm_up_count && setvar == SetVariation.one{
                self.sets.append(workoutSet(type: SetType.regular,weights: regular_weight,reps_assumed: [10]))
            }
            else if i < warm_up_count && setvar == SetVariation.alternate{
                self.sets.append(workoutSet(type: SetType.warmup,weights: warm_up_weight,reps_assumed: [10,10]))
            }
            else if i > warm_up_count && setvar == SetVariation.alternate{
                self.sets.append(workoutSet(type: SetType.regular,weights: regular_weight,reps_assumed: [10,10]))
            }
            else if i < warm_up_count && setvar == SetVariation.maxout{
                self.sets.append(workoutSet(type: SetType.warmup,weights: warm_up_weight,reps_assumed: [10,10]))
            }
            else if i > warm_up_count && setvar == SetVariation.maxout{
                self.sets.append(workoutSet(type: SetType.regular,weights: warm_up_weight,reps_assumed: [10,10]))
            }
            i += 1
        }
        if(setvar == SetVariation.maxout){
            self.sets.popLast()
            self.sets.append(workoutSet(type: SetType.regular,weights: warm_up_weight,reps_assumed: [10]))
        }
    }
    func exercisePage()->any View{
        VStack{
            Text(self.name)
            ForEach(sets){aSet in
                    HStack{
                        Text(String(aSet.weights))
                        Text(self.repInputDisplay(thisSet: aSet))
                        Text(self.repAssumptionDisplay(thisSet: aSet))
                    }
                
                }
        }
    }
    func repInputDisplay(thisSet: workoutSet) -> String{
        var str = ""
        switch setvar {
        case .one:
            str += String(thisSet.reps_input[0])
            return str
        case .alternate:
            str += String(thisSet.reps_input[0])
            str += String(thisSet.reps_input[1])
            return str
        case .maxout:
            str += String(thisSet.reps_input[0])
            str += String(thisSet.reps_input[1])
            return str
        }
    }
    func repAssumptionDisplay(thisSet: workoutSet) -> String{
        var str = ""
        switch setvar {
        case .one:
            str += String(thisSet.reps_assumed[0])
            return str
        case .alternate:
            str += String(thisSet.reps_assumed[0])
            str += String(thisSet.reps_assumed[1])
            return str
        case .maxout:
            str += String(thisSet.reps_assumed[0])
            str += String(thisSet.reps_assumed[1])
            return str
        }
    }
    
}

