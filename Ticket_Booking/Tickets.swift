//
//  Tickets.swift
//  Ticket_Booking
//
//  Created by Abdulloh on 03/11/22.
//

import SwiftUI

struct Tickets: View {
    @State var tickets = [
        TicketModel(image: "thor", title: "Thor", subtitle: "Love and Thunder"),
        TicketModel(image: "panther", title: "Black Panther", subtitle: "Wakanda Forever"),
        TicketModel(image: "scarlet", title: "Doctor Strange", subtitle: "in the Multiverse of Madness")
    ]
    
    var body: some View {
        ZStack {
            ForEach(tickets) { ticket in
                InfiniteStackView(tickets: $tickets, ticket: ticket)
            }
        }
    }
}

struct Tickets_Previews: PreviewProvider {
    static var previews: some View {
        Tickets()
    }
}

struct InfiniteStackView: View {
    @Binding var tickets: [TicketModel]
    var ticket: TicketModel
    @GestureState var isDragging = false
    @State var offset: CGFloat = .zero
    
    var body: some View {
        VStack {
            Ticket(title: ticket.title, subtitle: ticket.subtitle, image: ticket.image)
        }
        .frame(width: .infinity, height: .infinity)
        .zIndex(getIndex() == 0 && offset > 100 ? Double(CGFloat(tickets.count) - getIndex()) - 1: Double(CGFloat(tickets.count) - getIndex()))
        .offset(x: offset)
        .rotationEffect(.degrees(getRotation(angle: 10)))
        .rotationEffect(getIndex() == 1 ? .degrees(-6) : .degrees(0))
        .rotationEffect(getIndex() == 2 ? .degrees(6) : .degrees(0))
        .scaleEffect(getIndex() == 0 ? 1 : 0.9)
        .offset(x: getIndex() == 1 ? -40 : 0)
        .offset(x: getIndex() == 2 ? 40 : 0)
        .gesture (
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    var translation = value.translation.width
                    translation = tickets.first?.id == ticket.id ? translation : 0
                    translation = isDragging ? translation : 0
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        offset = translation
                    }
                })
                .onEnded({ value in
                    let width = UIScreen.main.bounds.size.width
                    let swipeRight = offset > (width / 4)
                    let swipeLeft = offset < (width / 4)
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if swipeRight || swipeLeft{
                            offset = width
                            removeAndAdd()
                        } else {
                            offset = .zero
                        }
                        
                        offset = .zero
                    }
                })
            
        )
    }
    
    func getIndex() -> CGFloat {
        let index = tickets.firstIndex { ticket in
            return self.ticket.id == ticket.id
        } ?? 0
        
        return CGFloat(index)
    }
    
    func getRotation(angle: Double) -> Double {
        let width = UIScreen.main.bounds.size.width
        let progress = offset / width
        
        return Double(progress*angle)
    }
    
    func removeAndAdd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            var updateTicket = ticket
            updateTicket.id = UUID().uuidString
            
            tickets.append(updateTicket)
            
            withAnimation(.spring()) {
                tickets.removeFirst()
            }
        }
    }
}
