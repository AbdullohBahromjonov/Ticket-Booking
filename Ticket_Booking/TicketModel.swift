//
//  TicketModel.swift
//  Ticket_Booking
//
//  Created by Abdulloh on 02/11/22.
//

import Foundation

struct TicketModel: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var subtitle: String
}

var tickets = [
    TicketModel(image: "thor", title: "Thor", subtitle: "Love and Thunder"),
    TicketModel(image: "panther", title: "Black Panther", subtitle: "Wakanda Forever"),
    TicketModel(image: "scarlet", title: "Doctor Strange", subtitle: "in the Multiverse of Madness")
]
