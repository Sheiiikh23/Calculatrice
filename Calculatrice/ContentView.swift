//
//  ContentView.swift
//  Calculatrice
//
//  Created by Cheikh SECK on 11/03/2022.
//

import SwiftUI

enum calcButton: String {
    case une = "1"
    case deux = "2"
    case trois = "3"
    case quatre = "4"
    case cinq = "5"
    case six = "6"
    case sept = "7"
    case huit = "8"
    case neuf = "9"
    case zero = "0"
    case egale = "="
    case addition = "+"
    case soustraction = "–"
    case multiplication = "x"
    case division = "/"
    case pourcentage = "%"
    case negatif = "–/+"
    case decimale = ","
    case supprimer = "AC"
    
    var buttonColor: Color {
        switch self {
        case .addition, .soustraction, .multiplication, .division, .egale:
            return Color.init(Color.RGBColorSpace.sRGB, red: 15/255.0, green: 30/255.0, blue: 60/255.0, opacity: 1)
        case .supprimer, .negatif, .pourcentage:
            return Color.init(Color.RGBColorSpace.sRGB, red: 50/255.0, green: 30/255.0, blue: 50/255.0, opacity: 1)
        default:
            return Color.init(Color.RGBColorSpace.sRGB, red: 30/255.0, green: 20/255.0, blue: 75/255.0, opacity: 1)
        }
    }
    
}

enum Operation {
    case addition, soustraction, multiplication, division, aucun
}

struct ContentView: View {
    
    @State var currentOperation: Operation = .aucun
    @State var value = "0"
    @State var runningNumber = 0
    
    let buttons: [[calcButton]] = [
        [.supprimer, .negatif, .pourcentage, .division],
        [.sept, .huit, .neuf, .multiplication],
        [.quatre, .cinq, .six, .soustraction],
        [.une, .deux, .trois, .addition],
        [.zero, .decimale, .egale]

    ]
    var body: some View {
        ZStack {
            Color.init(Color.RGBColorSpace.sRGB, red: 30/255.0, green: 5/255.0, blue: 75/255.0, opacity: 30).edgesIgnoringSafeArea(.all)
                
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .font(.system(size: 70))
                        .bold()
                        .foregroundColor(Color.init(Color.RGBColorSpace.sRGB, white: 12, opacity: 1))
                }
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                .bold()
                                .font(.system(size: 50))
                                .frame(
                                    width: self.buttonwidth(item: item),
                                    height: self.buttonHeight()
                                )
                                    //Color.init(UIColor(displayP3Red: 40/255.0, green: 40/255.0, blue: 65/255.0, alpha: 4)))
                                    .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(40 * 2)
                                
                            })
                        }
                    }.padding(.bottom, 3)
                    
                }
            }
        }
    }
    func didTap(button: calcButton) {
        switch button {
        case .addition, .soustraction, .multiplication, .division, .egale:
            if button == .addition {
                self.currentOperation = .addition
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .soustraction {
                self.currentOperation = .soustraction
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multiplication {
                self.currentOperation = .multiplication
                self.runningNumber = Int(self.value) ?? 0
                
            } else if button == .division {
                self.currentOperation = .division
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .egale {
                let runningvalue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .addition: self.value = "\(runningvalue + currentValue)"
                case .multiplication: self.value = "\(runningvalue * currentValue)"
                case .division: self.value = "\(runningvalue / currentValue)"
                case .soustraction: self.value = "\(runningvalue - currentValue)"

                case .aucun:
                    break
                }
            }
            
            if button != .egale {
                self.value = "0"
            }
            
        case .supprimer:
            self.value = "0"
        
        case .negatif:
            self.value = "-\(runningNumber)"
            
        case .pourcentage:
        break
        
        default:
            let number = button.rawValue
            if self.value == "0" {
                self.value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
            
    
       
        }
    }
    
    func buttonwidth(item: calcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - 4 * 12) / 4) * 2

        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
