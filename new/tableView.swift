import Foundation
import SwiftUI
struct timeTable: View{
    @Binding var selectedA:String
    @Binding var selectedB:String
    @Binding var selectedC:String
    @StateObject var net:netWork

     let baseOfTimeTable:[String] = [
        "","월","화","수","목","금","1교시","2교시","3교시","4교시","5교시","6교시","7교시","창체","영어A","수학","문학A","확통","영어B","진로","미술","문학B","영어B","체육"
    ]
     var data:[Int] = Array(1...4)
     let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    var body: some View{
        NavigationView(){
            VStack(spacing: 0){
                Spacer()
                    .onAppear(){
                        net.getSchedule()
                        if(net.value.count==0)
                        {
                            net.value = Data([0,1,2,3,4,5,
                                              6,0,0,0,0,0,
                                              7,0,0,0,0,0,
                                              8,0,0,0,0,0,
                                              9,0,0,0,0,0,
                                              10,0,0,0,0,0,
                                              11,0,0,0,0,0,
                                              12,0,0,0,0,0])
                        }
                    }
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(net.value.indices,id:\.self) { i in
                        ZStack {
                            Rectangle()
                                .frame(height: 40)
                                .cornerRadius(5)
                                .foregroundColor(Color.accentColor)
                            Group{
                                switch Int(net.value[i]){
                                case 120:
                                    Text(selectedA)
                                        .font((selectedA.count>3) ? Font.system(size: 11, weight:.bold) : .body)
                                case 121:
                                    Text(selectedB)
                                        .font((selectedB.count>3) ? Font.system(size: 11, weight:.bold) : .body)
                                case 122:
                                    Text(selectedC)
                                        .font((selectedC.count>3) ? Font.system(size: 11, weight:.bold) : .body)
                                default:
                                    Text("\(baseOfTimeTable[Int(net.value[i])])")
                                }
                            }
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        }
                    }
                }.padding([.leading, .trailing], 13.0)
                    .padding([.top],5.0)
                Spacer()
            }
        }
    }
}
struct timeTable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(num: 1)
    }
}
