import Foundation
import SwiftUI
import UIColorHexSwift
struct setting:View{
    let screenSize: CGRect = UIScreen.main.bounds
    @Binding var baseColor:UIColor
    @Binding var selectedA:String
    @Binding var selectedB:String
    @Binding var selectedC:String
    @StateObject var net:netWork
    @State var popupEnable:Bool = false
    @State var color:Color = Color(UIColor(UserDefaults.standard.string(forKey: "defaultColor") ?? "#000000"))
    let AList = ["","프로그래밍","인공지능","생윤","정법","세지","경제","물리","화학","생명","지구"]
    let BList = ["","프로그래밍","인공지능","생윤","정법","세지","경제","물리","화학","생명","지구"]
    let CList = ["","프로그래밍","인공지능","생윤","정법","세지","경제","물리","화학","생명","지구"]
    var body: some View{
        ZStack{
            VStack{
                Group{
                    ZStack{
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        HStack{
                            ZStack{
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .clipShape(Circle())
                                    .foregroundColor(Color(baseColor))
                            }
                            .padding([.top,.bottom,.leading],10)
                            Text("\n\(net.name)\n")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading,13)
                                .onChange(of: net.name)
                            {(new) in
                                self.popupEnable = false
                            }
                            Spacer()
                        }.onTapGesture()
                        {
                            if(net.isConnected){
                                popupEnable.toggle()
                            }
                        }
                    }.padding(.top,20)
                    ZStack{
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        HStack{
                            Group{
                                Text("\nColor\n")
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                ZStack{
                                    
                                    ColorPicker("", selection: $color)
                                        .onChange(of: color)
                                    {i in
                                        UserDefaults.standard.set(UIColor(color).hexString(true), forKey: "defaultColor")
                                        baseColor = UIColor(color)
                                    }
                                }
                            }.padding(.horizontal)
                        }
                    }
                    ZStack{
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        HStack{
                            Group{
                                Text("\n선택 과목A\n")
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
                                Spacer()
                                ZStack{
                                    Picker(selection: $selectedA, label: Text("")) {
                                        ForEach(AList,id:\.self)
                                        {
                                            Text($0)
                                        }
                                    }.onChange(of: selectedA)
                                    { i in
                                        UserDefaults.standard.set(selectedA, forKey: "A")
                                    }
                                }
                            }.padding(.horizontal)
                        }
                    }
                    ZStack{
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        HStack{
                            Group{
                                Text("\n선택 과목B\n")
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
                                Spacer()
                                Picker(selection: $selectedB, label: Text("")) {
                                    ForEach(BList,id:\.self)
                                    {
                                        Text($0)
                                    }
                                }.onChange(of: selectedB)
                                { i in
                                    UserDefaults.standard.set(selectedB, forKey: "B")
                                }
                            }.padding(.horizontal)
                        }
                    }
                    ZStack{
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        HStack{
                            Group{
                                Text("\n선택 과목C\n")
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
                                Spacer()
                                Picker(selection: $selectedC, label: Text("")) {
                                    ForEach(BList,id:\.self)
                                    {
                                        Text($0)
                                    }
                                }.onChange(of: selectedC)
                                { i in
                                    UserDefaults.standard.set(selectedC, forKey: "C")
                                }
                            }.padding(.horizontal)
                        }
                    }
                }.padding([.horizontal,.leading],20)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            VStack{
                Spacer()
                if(popupEnable){
                    popupUI(isEnable: $popupEnable,net:net)
                }
            }.aspectRatio(CGSize(width: 10, height: 14.6),contentMode: .fit)
        }
    }
}
struct setting_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(num: 2)
    }
}
