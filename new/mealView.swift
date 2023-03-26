//
//  mealView.swift
//  new
//
//  Created by 정재민 on 2023/03/23.
//

import Foundation
import SwiftUI
struct mealView:View {
    @StateObject var net:netWork
    var dateFormat = DateFormatter()
    var body: some View{
        
        ScrollViewReader { value in
            ScrollView(.horizontal,showsIndicators: false)
            {
                HStack(spacing: 20) {
                    Text("               ")
                    ForEach(0..<20) {
                        i in
                        VStack{
                            Group{
                                ZStack{
                                    Rectangle()
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.accentColor, lineWidth: 2)
                                        )
                                    VStack{
                                        Text("\(net.getDate(date: Date(timeInterval: TimeInterval(86400*(i-6)), since: Date()))) (점심)")
                                            .padding([.top,.horizontal,.leading])
                                            .fontWeight(.bold)
                                        
                                        Text("____________________________")
                                            .foregroundColor(Color.accentColor)
                                            .fontWeight(.bold)
                                        Spacer()
                                        Text("\((net.mealList["\(net.getDate1(date: Date(timeInterval: TimeInterval(86400*(i-6)), since: Date())))2"]) ?? "없음")")
                                            .padding([.horizontal,.leading])
                                            .frame(width:230)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .onAppear(){
                                                if(net.isConnected){
                                                    net.getMeal(d: net.getDate1(date: Date(timeInterval: TimeInterval(86400*(i-6)), since: Date())), type: 2)
                                                    net.getMeal(d: net.getDate1(date: Date(timeInterval: TimeInterval(86400*(i-6)), since: Date())), type: 3)
                                                }
                                            }
                                        Spacer()
                                    }
                                    
                                }
                                ZStack{
                                    Rectangle()
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.accentColor, lineWidth: 2)
                                        )
                                    VStack{
                                        Text("\(net.getDate(date: Date(timeInterval: TimeInterval(86400*(i-6)), since: Date()))) (저녘)")
                                            .padding([.top,.horizontal,.leading])
                                            .fontWeight(.bold)
                                        Text("____________________________")
                                            .foregroundColor(Color.accentColor)
                                            .fontWeight(.bold)
                                        Spacer()
                                        Text("\((net.mealList["\(net.getDate1(date: Date(timeInterval: TimeInterval(86400*(i-6)), since: Date())))3"]) ?? "없음")")
                                            .padding([.horizontal,.leading])
                                            .frame(width:230)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                    }
                                }
                                
                            }.padding([.top])
                                .padding([.horizontal,.leading],30)

                        }.padding(.bottom,30)
                            .id(i)
                    }.onAppear(){
                        value.scrollTo(6)
                        
                    }
                    Text("               ")
                }
            }.background(Color(.systemGray6))
                
        }
    }
}

struct mealPreview:PreviewProvider {
    static var previews: some View
    {
        ContentView(num:3)
    }
    
}
