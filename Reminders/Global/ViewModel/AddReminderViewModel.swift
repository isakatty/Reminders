//
//  AddReminderViewModel.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/9/24.
//

import Foundation

final class AddReminderViewModel {
    var inputSegmentedTrigger = Observable(0)
    var inputDatePickerTrigger = Observable(Date())
    var inputBackBtnTrigger: Observable<Bool> = Observable(false)
    
    var outputPriority: Observable<Priority?> = Observable(Priority.none)
    var outputDate = Observable(Date())
    var outputBackBtn: Observable<Bool> = Observable(false)
    
    init() {
        inputSegmentedTrigger.bind { [weak self] index in
            guard let self else { return }
            self.segmentedAction(index)
        }
        inputDatePickerTrigger.bind { [weak self] date in
            guard let self else { return }
            self.outputDate.value = date
        }
        inputBackBtnTrigger.bind { [weak self] isTrue in
            guard let self else { return }
            if isTrue {
                self.outputBackBtn.value = true
            }
        }
    }
    
    private func segmentedAction(_ index: Int) {
        outputPriority.value = Priority.allCases[index]
    }
}
