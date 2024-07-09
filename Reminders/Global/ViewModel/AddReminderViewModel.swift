//
//  AddReminderViewModel.swift
//  Reminders
//
//  Created by Jisoo Ham on 7/9/24.
//

import Foundation

final class AddReminderViewModel {
    var inputSegmentedTrigger = Observable(0)
    
    var outputPriority: Observable<Priority?> = Observable(Priority.none)
    
    init() {
        inputSegmentedTrigger.bind { [weak self] index in
            guard let self else { return }
            self.segmentedAction(index)
        }
    }
    
    private func segmentedAction(_ index: Int) {
        outputPriority.value = Priority.allCases[index]
    }
}
