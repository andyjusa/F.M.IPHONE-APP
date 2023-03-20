import Foundation
import SwiftUI
struct timeTable: View{
    var basecolor:Binding<Color>
    var selectedA:Binding<String>
    var selectedB:Binding<String>
    var selectedC:Binding<String>
    @StateObject var net:netWork

     let baseOfTimeTable:[String] = [
        "","월","화","수","목","금","1교시","2교시","3교시","4교시","5교시","6교시","7교시","창체","영어","수학","문학","확통","영어B","진로"
    ]
     var timeTable:[Int8] = [
    0,1,2,3,4,5,6,13,13,13,13,13,7,13,13,13,13,13,8,13,13,13,13,13,9,13,13,13,13,13,10,13,13,13,13,13,11,13,13,13,13,13,12,121,122,120,12,13
    ]
     var data:[Int] = Array(1...4)
     let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    var body: some View{
        VStack(spacing: 0){
            Spacer()
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(net.value.indices,id:\.self) { i in
                    ZStack {
                        Rectangle()
                            .frame(height: 40)
                            .cornerRadius(5)
                            .foregroundColor(basecolor.wrappedValue)
                        Group{
                            switch Int(net.value[i]){
                            case 120:
                                Text(selectedA.wrappedValue)
                            case 121:
                                Text(selectedB.wrappedValue)
                            case 122:
                                Text(selectedC.wrappedValue)
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
struct timeTable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(num: 1)
    }
}
