//
//  ViewController.swift
//  HWAlarm
//
//  Created by Евгений Забродский on 20.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var viewFirstLabel: UIView!
    @IBOutlet weak var vloumeLevelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var viewSecondLabel: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var viewThirdLabel: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var switchTime: UISwitch!
    @IBOutlet weak var clearButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addDoneButton(textField)
        
        
        
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        textField.text = String(slider.value)
        progressView.progress = slider.value
        
    }
    @IBAction func textFieldAction(_ sender: UITextField) {
        guard let text = sender.text else {return}
        if let currentValue = Float(text) {
            if currentValue > 1 {showAlert(title: "Uncorrect value", message: "Enter value from 0 to 1")}
            switch sender.tag {
            case 0:
                slider.value = currentValue
                progressView.progress = currentValue
            default:
                break
            }
            } else {showAlert(title: "Uncorrect value", message: "Enter value from 0 to 1")}
        
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        labelTime.text = formatter.string(from: datePicker.date)
        
        
    }
    @IBAction func switchAction(_ sender: UISwitch) {
        if switchTime.isOn {
            setTimeButton.isEnabled = true
            clearButton.isEnabled = true
            datePicker.isEnabled = true
        } else  {
            setTimeButton.isEnabled = false
            clearButton.isEnabled = false
            datePicker.isEnabled = false
            labelTime.text = ""
            
        }
        
        
    }
    @IBAction func clearButtonAction(_ sender: UIButton) {
        labelTime.text = ""
    }
    
    
    // MARK: - Private
    
    private func setupUI() {
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .red
        textField.keyboardType = .decimalPad
        datePicker.datePickerMode = .time
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
}

// MARK: - ViewController + UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
}

extension ViewController {
    private func addDoneButton(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    
}

