// FavoriteDetailView
import SwiftUI

struct FavoriteDetailView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var favorite: Favorite
    
    @State private var isEditing = false
    @State private var editedPrice: String = ""
    @State private var editedFormat: Favorite.GameFormat = .physical
    
    var body: some View {
        VStack {
            // ... (unchanged code)

            if isEditing {
                // Editable fields
                TextField("Price", text: $editedPrice)
                    .padding()
                    .keyboardType(.decimalPad)

                Picker("Format", selection: $editedFormat) {
                    Text("Physical").tag(Favorite.GameFormat.physical)
                    Text("Digital").tag(Favorite.GameFormat.digital)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button("Save Changes") {
                    saveChanges()
                    isEditing.toggle()
                }
            } else {
                // Display-only fields
                Text("Price: \(favorite.price != nil ? "$\(favorite.price!)" : "N/A")")
                    .padding()

                Text("Format: \(favorite.format?.rawValue.capitalized ?? "N/A")")
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    // Navigate back to the collection view
                    // You may need to adjust this based on your navigation structure
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Cancel" : "Edit") {
                    if isEditing {
                        // Cancel editing
                        isEditing.toggle()
                    } else {
                        // Start editing
                        editedPrice = favorite.price.map(String.init) ?? ""
                        editedFormat = favorite.format ?? .physical
                        isEditing.toggle()
                    }
                }
            }
        }
        .padding()
    }

    private func saveChanges() {
        // Update the favorite with edited values
        favorite.price = Double(editedPrice) ?? nil
        favorite.format = editedFormat
        // Save changes to the model context
        do {
            try modelContext.update(favorite)
        } catch {
            print("Error updating favorite: \(error)")
            // Handle the error appropriately (e.g., show an alert)
        }
    }
}
