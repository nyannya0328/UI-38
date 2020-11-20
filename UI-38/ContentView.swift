//
//  ContentView.swift
//  UI-38
//
//  Created by にゃんにゃん丸 on 2020/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home()
                .navigationTitle("Combo")
            
            
        }.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var sampledata : [Data] = Array(repeating: Data(), count: 0)
    
    @State var rows : [[Data]] = []
    
    @State var width = UIScreen.main.bounds.width - 30
    
    
    var body: some View{
        ScrollView{
            
            VStack(spacing: -10){
                
                ForEach(rows.indices,id : \.self){index in
                    HStack(spacing : 10){
                        
                        ForEach(rows[index],id : \.self){value in
                            
                            Hexagon()
                                .fill(Color.red)
                                .frame(width: (width - 20) / 3, height: 130)
                                .offset(x: getoffset(index: index))
                                
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            .padding()
            .frame(width: width)
            
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing){
                    
                    
                    Menu(content: {
                        
                        Button(action: {
                            
                            withAnimation(.spring()){
                                
                                rows.removeAll()
                                sampledata.append(Data())
                                generateHoney()
                                
                                
                            }
                            
                            
                        }, label: {
                            
                           Text("ADD")
                            
                            
                        })
                        
                        
                        
                    }){
                        
                        
                        Image(systemName: "ellipsis.circle")
                            .font(.title3)
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
            })
            
            
            
        }
        .onAppear(perform: {
            generateHoney()
        })
        
        
        
        
    }
    func getoffset(index : Int) -> CGFloat{
        
        let current = rows[index].count
        
        let offset = ((width - 20) / 3) / 2
        
        if index != 0{
            
            let previous = rows[index - 1].count
            
            
            if current == 1 {
                
                if previous == 3{
                    
                    
                    return -offset
                }
                
                
            }
            
            
        }
        
        return 0
        
        
    }
    
    
    
    
    func generateHoney(){
        var count = 0
        var generated : [Data] = []
        
        for i in sampledata{
            generated.append(i)
            
            if generated.count == 2{
                
                if let last = rows.last{
                    if last.count == 3{
                        
                        rows.append(generated)
                        generated.removeAll()
                        
                        
                    }
                    
                    
                    
                }
                
                if rows.isEmpty{
                    rows.append(generated)
                    generated.removeAll()
                    
                    
                }
                
                
                
            }
            
            
            if generated.count == 3{
                
                
                if let last = rows.last{
                    
                    if last.count == 2{
                        
                        rows.append(generated)
                        generated.removeAll()
                        
                    }
                    
                }
            }
            
            count += 1
            
            if count == sampledata.count && !generated.isEmpty{
                
                rows.append(generated)
                
                
                
            }
            
            
            
            
        }
        
        
        
        
    }
    
}

struct Hexagon : Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            let pt1 = CGPoint(x: 0, y: 20)
            let pt2 = CGPoint(x: 0, y: rect.height - 20)
            let pt3 = CGPoint(x: rect.width / 2, y: rect.height)
            let pt4 = CGPoint(x: rect.width, y: rect.height - 20)
            let pt5 = CGPoint(x: rect.width, y: 20)
            let pt6 = CGPoint(x: rect.width / 2, y: 0)
            
            path.move(to: pt6)
            
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
            path.addArc(tangent1End: pt4, tangent2End: pt5, radius: 15)
            path.addArc(tangent1End: pt5, tangent2End: pt6, radius: 15)
            path.addArc(tangent1End: pt6, tangent2End: pt1, radius: 15)
            
            
        }
    }
}
