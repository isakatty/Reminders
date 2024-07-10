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
    
    // input의 초기값으로 nil
    var inputBackBtnTrigger: Observable<Void?> = Observable(nil)
    
    var outputPriority: Observable<Priority?> = Observable(Priority.none)
    var outputDate = Observable(Date())
    var outputBackBtn: Observable<Void?> = Observable(nil)
    
    init() {
        inputSegmentedTrigger.bind { [weak self] index in
            guard let self else { return }
            self.segmentedAction(index)
        }
        inputDatePickerTrigger.bind { [weak self] date in
            guard let self else { return }
            self.outputDate.value = date
        }
        inputBackBtnTrigger.bind { [weak self] value in
            guard let self else { return }
            self.outputBackBtn.value = value
        }
    }
    
    private func segmentedAction(_ index: Int) {
        outputPriority.value = Priority.allCases[index]
    }
}
