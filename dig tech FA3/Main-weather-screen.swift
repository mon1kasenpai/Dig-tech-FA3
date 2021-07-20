//
//  ContentView.swift
//  dig tech FA3
//
//  Created by Jodie Haruka on 8/6/21.
//
import foundation
import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        ZStack{
            //MARK:BACKGROUND
            if let icon = networkManager.weather?.current.icon.rawValue{
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }
            
            //MARK: FOREGROUND
            VStack{
                VStack(spacing:5){
                    //MARK: Current Temperature
                    HStack(alignment: .center){
                        if let currentIcon = networkManager.weather?.current.icon {
                            currentIcon.image
                                .font(.system(size: 40))
                                .foregroundColor(.black)
                        }else {
                            Image(systemName: "arrow.clockwise.icloud")
                                .font(.system(size: 40))
                        }
                        if let currentTemp = networkManager.weather?.current.temperature {
                            Text("\(currentTemp, specifier: "%.1f")˚C")
                                .font(.custom("01 Digit", size: 60))
                        } else {
                            Text("--.-")
                                .font(.custom("01 Digit", size: 60))
                        }
                    }.frame(height:60)
                    //MARK: High/Low
                    HStack{
                        VStack{
                            Text("HIGH")
                                .font(.custom("01 Digit", size: 15))
                                .foregroundColor(.red)
                            HStack{
                                if let myDailyHigh = networkManager.weather?.week.list.first!.maxTemperature {
                                    Text("\(myDailyHigh, specifier: "%.0f")")
                                        .font(.custom("01 Digit", size: 20))
                                        .foregroundColor(.red)
                                } else {
                                    Text("--.-˚")
                                        .font(.custom("01 Digit", size: 20))
                                        .foregroundColor(.red)
                                }
                                
                            }
                        }
                        Divider()
                        VStack{
                            Text("LOW")
                                .font(.custom("01 Digit", size: 15))
                            HStack{
                                if let myDailyLow = networkManager.weather?.week.list.first!.minTemperature {
                                    Text("\(myDailyLow, specifier: "%.0f")")
                                        .font(.custom("01 Digit", size: 20))
                                } else {
                                    Text("--.-˚")
                                        .font(.custom("01 Digit", size: 20))
                                }
                            }
                        }
                    }.frame(height:40)
                    if let summary = networkManager.weather?.week.list.first!.summary {
                        Text(summary)
                            .font(.custom("01 Digit", size: 20))
                            .padding()
                    } else {
                        Text("Downloading weather data - please be patient.")
                            .font(.custom("01 Digit", size: 20))
                            .padding()
                    }
                }
                
                Spacer()
                
                //MARK:OTHER DETAILS
                VStack{
                    HStack{
                        VStack{
                            Text("HUMIDITY")
                                .font(.custom("01 Digit", size: 12))
                            if let humidity = networkManager.weather?.week.list.first!.humidity {
                                Text("\(humidity*100, specifier: "%.0f")%")
                                    .font(.custom("01 Digit", size: 20))
                            } else {
                                Text("--%")
                                    .font(.custom("01 Digit", size: 20))
                            }
                        }
                        Divider()
                        VStack{
                            Text("DEW POINT")
                                .font(.custom("Hello Avocado", size: 12))
                            if let dewPoint = networkManager.weather?.week.list.first!.dewPoint {
                                Text("\(dewPoint, specifier: "%.0f")˚C")
                                    .font(.custom("01 Digit", size: 20))
                            } else {
                                Text("--˚")
                                    .font(.custom("01 Digit", size: 20))
                            }
                        }
                        Divider()
                        VStack{
                            Text("PRESSURE")
                                .font(.custom("Hello Avocado", size: 12))
                            if let pressure = networkManager.weather?.week.list.first!.pressure{
                                Text("\(pressure, specifier: "%.1f") hPa")
                                    .font(.custom("Hello Avocado", size: 20))
                            } else {
                                Text("----.- hPa")
                                    .font(.custom("Hello Avocado", size: 20))
                            }
                        }
                        Divider()
                        VStack{
                            Text("WIND SPEED")
                                .font(.custom("Hello Avocado", size: 12))
                            if let windSpeed = networkManager.weather?.week.list.first!.windSpeed {
                                Text("\(windSpeed, specifier: "%.1f") Km/h")
                                    .font(.custom("Hello Avocado", size: 20))
                            } else {
                                Text("-.- Km/h")
                                    .font(.custom("Hello Avocado", size: 20))
                            }
                        }
                        Divider()
                        VStack{
                            Text("RAIN")
                                .font(.custom("Hello Avocado", size: 12))
                            if let rain = networkManager.weather?.week.list.first!.precipProbability {
                                Text("\(rain, specifier: "%.0f")%")
                                    .font(.custom("Hello Avocado", size: 20))
                            } else {
                                Text("--%")
                                    .font(.custom("Hello Avocado", size: 20))
                            }
                        }
                    }
                    .padding(.init(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    HStack{
                        ForEach (1..<8) {index in
                            VStack{
                                //
                                if let currentIcon = networkManager.weather?.week.list[index].icon {
                                    currentIcon.image
                                }else {
                                    Image(systemName: "arrow.clockwise.icloud")
                                }
                                //

                                Text("\(weekday(from: Date(), index:index))")
                                    .font(.custom("Hello Avocado", size: 10))
                                HStack{
                                    if let currentMax = networkManager.weather?.week.list[index].maxTemperature {
                                        Text("\(currentMax, specifier:"%.0f")˚")
                                            .font(.custom("Hello Avocado", size: 14))
                                    } else {
                                        Text("--˚")
                                            .font(.custom("Hello Avocado", size: 14))
                                    }
                                    if let currentMin = networkManager.weather?.week.list[index].minTemperature {
                                        Text("\(currentMin, specifier:"%.0f")˚")
                                            .font(.custom("Hello Avocado", size: 14))
                                    } else {
                                        Text("--˚")
                                            .font(.custom("Hello Avocado", size: 14))
                                    }
                                    
                                }
                            }.frame(width:50)
                            .padding(.init(top: 10.0, leading: 1, bottom: 10.0, trailing: 1.0))
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.secondary, lineWidth: 1)
                            )
                        }
                    }
                    
                    Spacer()
                        .frame(height:80)//to take care of ignoringSafeArea for the foreground...
                }
                .frame(height:120)
                .padding()
                
                Image("DarkSky")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:70)
                
            }
            /*
            .background(
                Image("clear-day")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )*/

        }
        
    }
}
