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
    @State var BaseColor : Color = .blue
    @State var selectedA:String = "나"
    @State var selectedB:String = "나"
    @State var selectedC:String = "나"
    @StateObject var net = netWork()
    var body: some View {
        VStack{
            //TODO: USER DATA SAVE && LOAD
            Text((net.isConnected) ? "Online" : "Offline")
                .foregroundColor(.red)
            TabView(selection: $num) {
                Group{
                    noticeView(baseColor: $BaseColor).tabItem{
                        Label("알림",systemImage: "bell")
                    }.tag(0)
                    timeTable( basecolor: $BaseColor,selectedA: $selectedA,selectedB: $selectedB,selectedC: $selectedC,net: net).tabItem {
                        Label("시간표", systemImage: "tablecells")
                    }.tag(1)
                    setting(baseColor: $BaseColor,selectedA: $selectedA,selectedB: $selectedB,selectedC: $selectedC,net:net ).tabItem {
                        Label("설정",systemImage: "gearshape")
                    }.tag(2)
                }
                .background(Color(.systemGray6))
                .padding(.bottom)
                
            }.accentColor(BaseColor)
        }.background(Color(.systemGray6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(num: 1)
    }
}
