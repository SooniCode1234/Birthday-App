//
//  ContentView.swift
//  Birthday-App
//
//  Created by Sooni Mohammed on 2020-11-17.
//

import SwiftUI

struct HolidayListView: View {
    
    @StateObject var viewModel = HolidayListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    SearchHolidayView(viewModel: viewModel)
                    
                    List {
                        ForEach(viewModel.holidays, id: \.name) { holiday in
                            HolidayListCell(holiday: holiday)
                        }
                    }.listStyle(PlainListStyle())
                }
                .navigationBarTitle(viewModel.holidayCount, displayMode: .inline)
            }
            .onAppear { viewModel.getHoliday() }
            
            if viewModel.isLoading {
                LoadingView()
            }
            
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayListView()
    }
}

struct SearchHolidayView: View {
    @ObservedObject var viewModel: HolidayListViewModel
    
    var body: some View {
        TextField("Search Holiday", text: $viewModel.searchedHoliday, onCommit: {
            viewModel.getHoliday(countryCode: viewModel.searchedHoliday)
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .background(
            Color(.placeholderText)
                .frame(width: UIScreen.main.bounds.width, height: 70))
        .padding()
    }
}

struct HolidayListCell: View {
    var holiday: HolidayDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(holiday.name)
                .font(.title3)
                .fontWeight(.medium)
            
            Text(holiday.date.iso)
                .font(.subheadline)
        }
    }
}
