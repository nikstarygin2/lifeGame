//
//  LifeGameA11yIds.swift
//  LifeGameUITestsSupport
//
//  Created by Nikita Starygin on 08.07.2024.
//

import Foundation

public enum LifeGameA11yIds {
    public enum Settings {
        public static let columnsStepper = "settings_columns_stepper"
        public static let rowsStepper = "settings_rows_stepper"
        public static let startGame = "settings_rows_start_game_button"
        public static let autoGame = "settings_auto_game_switcher"
    }

    public enum Game {
        public static let nextGenButton = "game_next_gen_button"
        public static let restartButton = "game_restart_button"
        public static let generationCounter = "game_generation_counter"
    }
}
