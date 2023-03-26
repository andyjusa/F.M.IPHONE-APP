import Foundation
import SwiftUI
struct noticeView:View{
    struct noticeType {
        let title: String
        let detail: String
    }
    @State var listOfNotice:[noticeType] = [noticeType(title:"수학 숙제",detail:"수학 숙제 13~ 15쪽 까지")]
    @State var a:Int = 0
    @State var isPressed = false
    var body: some View
    {
        ZStack{
            if(isPressed)
            {
                NavigationView(){
                    VStack{
                        HStack{
                            Text("\(listOfNotice[a].detail)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                                .padding([.top, .leading], 21.0)
                                .toolbar{
                                    ToolbarItem {
                                        Button("완료") {isPressed=false}
                                    }
                                }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }else{
                List{
                    ForEach(listOfNotice.indices,id:\.self){ i in
                        ZStack{
                            Rectangle()
                                .cornerRadius(4.0)
                                .foregroundColor(.white)
                            HStack{
                                Text(listOfNotice[i].title)
                                Spacer()
                            }
                        }.onTapGesture {
                            a=i
                            isPressed = true
                        }
                    }
                }
            }
        }
    }
}
struct noticeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(num: 0)
    }
}
