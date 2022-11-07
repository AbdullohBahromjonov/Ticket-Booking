//
//  Ticket.swift
//  Ticket_Booking
//
//  Created by Abdulloh on 02/11/22.
//

import SwiftUI

struct Ticket: View {
    @State var title = "Thor"
    @State var subtitle = "Love and Thunder"
    @State var image = "thor"
    
    var body: some View {
        VStack {
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text(subtitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            .frame(width: 250, height: 460, alignment: .top)
            .foregroundColor(.white)
            .background(
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .overlay {
                VStack {
                    Spacer()
                    
                    BottomView()
                }
            }
            .mask (
                Image(image)
            )
        }
    }
}

struct Ticket_Previews: PreviewProvider {
    static var previews: some View {
        Ticket()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 1))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        return path
    }
}

struct BottomView: View {
    var body: some View {
        ZStack {
            VStack(spacing: -0.5) {
                Spacer()
                
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [8]))
                    .foregroundColor(.white)
                    .frame(height: 1)
                
                Color.white.opacity(0.2)
                    .background(.ultraThinMaterial)
                    .frame(width: 251, height: 140)
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
            }
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date: April 10")
                        Text("Row: 2")
                    }
                    
                    VStack(alignment: .trailing) {
                        Text("Time: 6 p.m.")
                        Text("Seats: 9, 10")
                    }
                }
                .font(.system(size: 13, weight: .regular, design: .rounded))
                
                Image("Codebar")
            }
        }
        .frame(width: 250, height: 140)
    }
}
