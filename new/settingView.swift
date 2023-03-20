import Foundation
import SwiftUI

struct setting:View{
    let screenSize: CGRect = UIScreen.main.bounds
    @Binding var baseColor:Color
    @Binding var selectedA:String
    @Binding var selectedB:String
    @Binding var selectedC:String
    @StateObject var net:netWork
    @State var popupEnable:Bool = false
    let AList = ["가","나","다"]
    let BList = ["가","나","다"]
    let CList = ["가","나","다"]
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
                                    .foregroundColor(baseColor)
                            }
                            .padding([.top,.bottom,.leading],10)
                            Text("\n\n로그인이 필요 합니다.\n\n")
                                .fontWeight(.bold)
                                .padding(.leading,13)
                            Spacer()
                        }.onTapGesture()
                        {
                            popupEnable.toggle()
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
                                    ColorPicker("", selection: $baseColor)
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
