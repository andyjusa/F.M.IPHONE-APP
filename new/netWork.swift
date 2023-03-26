import SocketIO
import Foundation
import Starscream
import Network



class netWork:ObservableObject{
    @Published var alram:String = ""
    @Published var id:Int = UserDefaults.standard.integer(forKey: "id") 
    @Published var name:String = UserDefaults.standard.string(forKey: "name") ?? "로그인이 필요함"
    @Published var value:Data = UserDefaults.standard.data(forKey: "schedule") ?? Data([0,1,2,3,4,5,
                                                                                       6,0,0,0,0,0,
                                                                                       7,0,0,0,0,0,
                                                                                       8,0,0,0,0,0,
                                                                                       9,0,0,0,0,0,
                                                                                       10,0,0,0,0,0,
                                                                                       11,0,0,0,0,0,
                                                                                       12,0,0,0,0,0])
    @Published var mealList:[String:String] = (UserDefaults.standard.dictionary(forKey: "mealList") as? [String:String] ?? [:])
    let manager = SocketManager(socketURL: URL(string: "http://192.168.123.199:8080")!, config: [.log(true), .compress])
    var socket:SocketIOClient!
    var count = 0
    @Published var isConnected: Bool = false
    init(){
        socket = self.manager.socket(forNamespace: "/")
        socket.on(clientEvent: .disconnect)
        {_,_ in
            self.isConnected = false
        }
        socket.on(clientEvent: .connect)
        {_,_ in
            self.isConnected = true
        }
        socket.on(clientEvent: .error)
        {arg0,arg1 in
            print("error \(arg0)")
            if(arg0 as? [String] == ["Could not connect to the server."])
            {
                self.isConnected = false           
            }
        }
        socket.on("errored")
        {data,sid in
            switch(data.first as! Int)
            {
            case 0:
                self.setAlram(message: "이메일을 보냄")
                break
            case 1:
                self.setAlram(message: "연결 성공")
                break
            case 2:
                self.setAlram(message: "아이디나 비밀번호가 일치하지 않습니다")
                break
            case 3:
                self.setAlram(message: "인증번호 불일치")
                break
            case 4:
                self.setAlram(message: "아이디가 존재합니다")
                break
            case 5:
                self.setAlram(message: "학번 중복")
                break
            case 6:
                self.setAlram(message: "회원가입 성공")
                break
            case 7:
                self.setAlram(message: "회원가입 실패")
                break
            default:
                break
            }

        }
        socket.on("schedule")
        {data,sid in
            UserDefaults.standard.set(((data.first as? Data)!), forKey: "schedule")
            self.value = ((data.first as? Data)!)
        }
        socket.on("logined")
        {data,sid in
            if data[0] as! String == "suceed"{
                self.setAlram(message: "로그인 성공함")
                self.name = data[2] as! String
                self.id = data[1] as! Int
                UserDefaults.standard.set(self.name, forKey: "name")
                UserDefaults.standard.set(self.id, forKey: "id")
                self.getSchedule()
            }
        }
        socket.on("schedule")
        {data,sid in
            self.value = ((data.first as? Data)!)
        }
        socket.connect()
        socket.on("mealInfo")
        {data,sio in
            print(data[1])
            self.mealList["\(String(data[0] as! Int))\(String(data[1] as! Int))"] = data[2] as? String
            UserDefaults.standard.set(self.mealList, forKey: "mealList")
        }
    }
    func connect() {
        socket.connect()
    }
    func getSchedule() {
        socket.emit("getSchedule", (self.id/100) as Int)
    }
    func email(s:String)
    {
        socket.emit("email", s)
    }
    func register(s:String,num:Int,name:String,psw:String)
    {
        socket.emit("register", [s,num,name,psw])
    }
    func login(name:String,psw:String)
    {
        socket.emit("login", [name,psw])
    }
    func disconnect() {
        socket.disconnect()
    }
    func getMeal(d:String,type:Int)
    {
        if(mealList["\(d)\(String(type))"] == nil)
        {
            socket.emit("getMeal", [d,type])
        }else{
//            print(mealList["\(d)\(String(type))"])
        }
    }
    func getDate(date:Date) -> String
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "M월 d일"
        return dateFormat.string(from: date)
    }
    func getDate1(date:Date) -> String
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyyMMdd"
        return dateFormat.string(from: date)
    }
    func setAlram(message:String)
    {
        self.alram = message
        self.count += 1
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            self.count -= 1
            if(self.count == 0)
            {
                self.alram = ""
            }
        }
    }
}

  
