//
//  NewCocktailModel.swift
//  CoctailsApp
//
//  Created by user on 30.07.2025.
//

import UIKit

protocol INewCocktailModel {
    func saveCocktail(title: String, instruction: String, image: UIImage?) async throws
    func validateCocktail(title: String, instruction: String) -> ValidationResult
}

struct ValidationResult {
    let isValid: Bool
    let errors: [String]
}

enum NewCocktailError: LocalizedError {
    case validationFailed([String])
    case saveFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .validationFailed(let errors):
            return errors.joined(separator: ", ")
        case .saveFailed(let error):
            return "Failed to save: \(error.localizedDescription)"
        }
    }
}

final class NewCocktailModel: INewCocktailModel {
    
    
    func saveCocktail(title: String, instruction: String, image: UIImage?) async throws {
        let validation = validateCocktail(title: title, instruction: instruction)
        guard validation.isValid else {
            throw NewCocktailError.validationFailed(validation.errors)
        }
        
        try await withCheckedThrowingContinuation {continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let context = CoreDataManager.shared.persistentContainer.viewContext
                    //let context = self.coreDataManager.persistentContainer.viewContext
                    let item = CocktailsCore(context: context)
                    item.title = title
                    item.instruction = instruction
                    
                    if let image = image, let data = image.jpegData(compressionQuality: 0.8) {
                        item.imageData = data
                    }
                    
                    CoreDataManager.shared.saveContext()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: NewCocktailError.saveFailed(error))
                }
            }
        }
    }
    
    func validateCocktail(title: String, instruction: String) -> ValidationResult {
        var errors: [String] = []
        
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("Title cannot be empty")
        }
        
        if instruction.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.append("Instruction cannot be empty")
        }
        
        if title.count > 100 {
            errors.append("Title is too long (max 100 characters)")
        }
        
        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }
}
