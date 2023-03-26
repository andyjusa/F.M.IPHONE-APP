import Foundation
import SwiftUI
import CryptoKit

struct popupUI:View
{
    @Binding var isEnable:Bool
    @State var isLogin:Bool = true
    @State var Email:String = ""
    @State var ID:String = ""
    @State var Code:String = ""
    @State var PSW:String = ""
    @State var PSWC:String = ""
    @State var checkAuto = false
    @StateObject var net:netWork
    
    var body: some View
    {
        NavigationView
        {
            
            VStack{
                Picker("Choose a color", selection: $isLogin) {
                    Text("로그인").tag(true)
                    Text("회원가입").tag(false)
                      }
                      .pickerStyle(.segmented)
                      .padding()
                      .cornerRadius(15)
                      .padding()
                //FIXME: TEXT INPUT의 위치 조정
                Group{
                    if(isLogin){
                        inputField(imageName: "person.fill", text: "아이디", value: $ID)
                            .textCase(.lowercase)
                            .autocapitalization(.none)
                        HStack{
                            Image(systemName: "lock")
                            SecureField(" 비밀번호",text: $PSW)
                                .padding(.horizontal,5)
                        }
                        HStack{
                            Spacer()
                            Label("자동 로그인",systemImage:(checkAuto) ? "square" : "checkmark.square.fill")
                                .foregroundColor(Color.accentColor)
                                .onTapGesture {
                                    checkAuto.toggle()
                                }
                        }
                        Text("\n\n\n\n\n")
                        
                        ZStack{
                            Rectangle().foregroundColor(Color.accentColor)
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 9, height: 1),contentMode: .fit)
                            Text("\n  로그인  \n").foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .onTapGesture {
                            net.login(name: ID, psw: SHA256.hash(data: PSW.data(using: .utf8)!).compactMap{ String(format: "%02x",$0)}.joined())
                        }
                    }else{
                        HStack{
                            inputField(imageName: "envelope.circle.fill", text: "학교 이메일", value: $Email)
                                .textCase(.lowercase)
                                .autocapitalization(.none)
                            Button("인증")
                            {
                                let emailTest = NSPredicate(format: "SELF MATCHES %@", "((23ms+[0-9]{4})|(mstr+[0-9]{2}))@h.jne.go.kr")
                                if(emailTest.evaluate(with: Email))
                                {
                                    net.email(s: Email)
                                }else{
                                    net.setAlram(message: "포맷이 일치하지 않음")
                                }
                            }
                        }
                        inputField(imageName: "number.square.fill", text: "인증번호", value: $Code)
                            .keyboardType(.decimalPad)
                        inputField(imageName: "person.fill", text: " 아이디", value: $ID)
                            .textCase(.lowercase)
                            .autocapitalization(.none)
                        HStack{
                            Image(systemName: "lock")
                            SecureField(" 비밀번호",text: $PSW)
                                .padding(.horizontal,5)
                        }
                        HStack{
                            Image(systemName: "lock.fill")
                            SecureField(" 비밀번호 재입력",text: $PSWC)
                                .padding(.horizontal,5)
                        }
                        ZStack{
                            Rectangle().foregroundColor(Color.accentColor)
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 9, height: 1),contentMode: .fit)
                            Text("\n  회원가입  \n").foregroundColor(.white)
                                .fontWeight(.bold)
                        }.onTapGesture {
                            net.register(s: Email, num: Int(Code) ?? 0, name: ID, psw: SHA256.hash(data: PSW.data(using: .utf8)!).compactMap{ String(format: "%02x",$0)}.joined())
                        }
                    }
                }.padding([.horizontal,.bottom],20)
                Spacer()
            }
                .toolbar {
                    ToolbarItem {
                        Button("취소") {
                            isEnable = false
                        }.padding([.horizontal,.top],10)
                    }
                }
                
        }
        .clipShape(RoundedRectangle(cornerRadius: 40,style: .circular))
        .shadow(radius: 200)
        .padding([.leading,.horizontal],20)
        .transition(AnyTransition.opacity.animation(.easeInOut))
        
    }
}
struct inputField:View{
    var imageName:String = ""
    var text:String = ""
    @Binding var value:String
    var body: some View{
        HStack{
            Image(systemName: imageName)
            ZStack{
                TextField(text, text: $value)
                    .foregroundColor(.gray)
                    .padding(.horizontal,7)
            }
        }
    }
}

struct popup: PreviewProvider {
    static var previews: some View {
        ContentView(num: 2)
    }
}
