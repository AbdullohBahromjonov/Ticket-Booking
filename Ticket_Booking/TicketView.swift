//
//  TicketView.swift
//  Ticket_Booking
//
//  Created by Abdulloh on 05/11/22.
//

import SwiftUI

struct TicketView: View {
    @State var animate = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Color"), Color("Color 1")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .foregroundColor(Color("Color 2"))
                .opacity(0.3)
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? -50 : -130, y: animate ? -30 : -100)
                .task {
                    withAnimation(.easeInOut(duration: 3).repeatForever()) {
                        animate.toggle()
                    }
                }
            
            Circle()
                .foregroundColor(Color("Color 3"))
                .opacity(0.3)
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? 50 : 130, y: animate ? 30 : 100)
            
            VStack(spacing: 25) {
                Text("Mobile Ticket")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Once you buy a movie ticket\nsimply scan the barcode to\nacces to your movie")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .regular))
                
                Spacer()
            }
            
            Tickets()
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
