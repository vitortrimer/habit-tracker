//
//  AddNewHabit.swift
//  HabitTracker
//
//  Created by Vitor Trimer on 30/09/22.
//

import SwiftUI

struct AddNewHabit: View {
    
    @EnvironmentObject var habitModel: HabitViewModel
    @Environment(\.self) var env
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Title", text: $habitModel.title)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(CGColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 0.3)), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                
                HStack(spacing: 0) {
                    ForEach(1...7, id:\.self) { index in
                        let color = getLabelColor(fromIndex: index)
                        let currentColor = getLabelColor(fromIndex: Int(habitModel.habitColor))
                        Circle()
                            .fill(color)
                            .frame(width: 33, height: 33)
                            .overlay (content: {
                                if color == currentColor {
                                    Image(systemName: "checkmark")
                                        .font(.caption.bold())
                                }
                            })
                            .onTapGesture {
                                withAnimation {
                                    habitModel.habitColor = String(index)
                                }
                            }
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Frequency")
                        .font(.callout.bold())
                    
                    let weekDays = Calendar.current.weekdaySymbols
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(weekDays, id: \.self) { day in
                                let index = habitModel.weekDays.firstIndex { value in
                                    return value == day
                                } ?? -1
                                let currentColor = getLabelColor(fromIndex: Int(habitModel.habitColor))
                                Text(day.prefix(3))
                                    .fontWeight(.semibold)
                                    .frame(minWidth: 45, maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(index != -1 ? currentColor : Color(CGColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 0.3)))
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            if index != -1 {
                                                habitModel.weekDays.remove(at: index)
                                            } else {
                                                habitModel.weekDays.append(day)
                                            }
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.top, 15)
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Reminder")
                            .fontWeight(.semibold)
                        
                        Text("Just notification")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: $habitModel.isReminderOn) {
                    }
                    .labelsHidden()
                }
                
                HStack(spacing: 12) {
                    Label {
                        Text(habitModel.reminderDate.formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color(CGColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 0.3)), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .onTapGesture {
                        withAnimation {
                            habitModel.showTimePicker.toggle()
                        }
                    }
                    
                    TextField("Description", text: $habitModel.reminderText)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(CGColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 0.3)), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                }
                .frame(height: habitModel.isReminderOn ? nil : 0)
                .opacity(habitModel.isReminderOn ? 1 : 0)
                
            }
            .animation(.easeInOut, value: habitModel.isReminderOn)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Habit")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .tint(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        Task {
                            if await habitModel.addHabit(context: env.managedObjectContext) {
                                env.dismiss()
                            }
                        }
                    }
                    .tint(.white)
                    .disabled(!habitModel.doneStatus())
                    .opacity(habitModel.doneStatus() ? 1 : 0.6)
                }
            }
        }
        .overlay {
            if habitModel.showTimePicker {
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                habitModel.showTimePicker.toggle()
                            }
                        }
                    
                    DatePicker.init("", selection: $habitModel.reminderDate, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(CGColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1)))
                        }
                        .padding()
                }
            }
        }
       
    }
}

struct AddNewHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabit()
            .environmentObject(HabitViewModel())
            .preferredColorScheme(.dark)
    }
}
