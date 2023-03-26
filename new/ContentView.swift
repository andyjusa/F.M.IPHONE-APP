//
//  ContentView.swift
//  app
//
//  Created by 정재민 on 2023/03/08.
//

import SwiftUI
import SocketIO
import Network


struct ContentView: View {
    @State var num:Int
    @State var BaseColor : UIColor = UIColor(UserDefaults.standard.string(forKey: "defaultColor") ?? "#000000FF")
    @State var selectedA:String = (UserDefaults.standard.string(forKey: "A") ?? "")
    @State var selectedB:String = (UserDefaults.standard.string(forKey: "B") ?? "")
    @State var selectedC:String = (UserDefaults.standard.string(forKey: "C") ?? "")
    @StateObject var net = netWork()
    var body: some View {
        ZStack{
            
            VStack{
                TabView(selection: $num) {
                    Group{
                        noticeView().tabItem{
                            Label("알림",systemImage: "bell")
                        }.tag(0)
                        timeTable(selectedA: $selectedA,selectedB: $selectedB,selectedC: $selectedC,net: net).tabItem {
                            Label("시간표", systemImage: "tablecells")
                        }.tag(1)
                            .onTapGesture {
                                
                                net.setAlram(message: "clicked")
                            }
                        mealView(net: net)
                            .tabItem()
                        {
                            Label("급식", systemImage: "fork.knife")
                        }
                        .tag(3)
                        setting(baseColor: $BaseColor,selectedA: $selectedA,selectedB: $selectedB,selectedC: $selectedC,net:net ).tabItem {
                            Label("설정",systemImage: "gearshape")
                        }.tag(2)
                    }
                    .background(Color(.systemGray6))
                    .padding(.bottom)
                    
                }.accentColor(Color(BaseColor))
            }.background(Color(.systemGray6))
            VStack{
                Text(net.alram)
                    .foregroundColor(.red)
                    .transition(.move(edge: .top))
                    .animation(.easeIn)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(num: 1)
    }
}
