import SwiftUI
import PDFKit
import SBJLayout

//TODO: make generic
public struct CharacterSheetPDFView: View {
	@State private var character: Character = Characters.first!
	@State private var theme: Theme = Themes.first!
	@State private var sheet: Sheet = Sheets.first!
	@State private var jargon: any Jargon = Jargons.first!

	@State private var pdfDocument: PDFDocument?
	@State private var exportURL: URL?
	@State private var errorMessage: String?

	public init() {
	}

	public var exportFileName: String {
		"\(character.person.identity.name)_Character_Sheet.pdf"
	}


	public var body: some View {
		NavigationStack {
			Group {
				if let pdfDocument {
					PDFKitView(document: pdfDocument)
				} else if let errorMessage {
					ContentUnavailableView(
						"Unable to Generate PDF",
						systemImage: "exclamationmark.triangle",
						description: Text(errorMessage)
					)
				} else {
					ProgressView("Generating character sheet…")
				}
			}
			.navigationBarTitle(character.person.identity.name, displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Menu {
						ForEach(Characters, id: \.person.identity.name) { item in
							Toggle(
								item.person.identity.name,
								isOn: Binding(
									get: {
										character.person.identity.name == item.person.identity.name
									},
									set: { selected in
										if selected {
											character = item
										}
									}
								)
							)
						}
					} label: {
						Label("Characters", systemImage: "person")
					}
				}

				ToolbarItem(placement: .primaryAction) {
					Menu {
						ForEach(Themes, id: \.name) { item in
							Toggle(
								item.name,
								isOn: Binding(
									get: {
										theme.name == item.name
									},
									set: { selected in
										if selected {
											theme = item
										}
									}
								)
							)
						}
					} label: {
						Label("Themes", systemImage: "paintpalette")
					}
				}

				ToolbarItem(placement: .primaryAction) {
					Menu {
						ForEach(Sheets, id: \.name) { item in
							Toggle(
								item.name,
								isOn: Binding(
									get: {
										sheet.name == item.name
									},
									set: { selected in
										if selected {
											sheet = item
										}
									}
								)
							)
						}
					} label: {
						Label("Sheets", systemImage: "document.on.document")
					}
				}

				ToolbarItem(placement: .primaryAction) {
					Menu {
						ForEach(Jargons, id: \.name) { item in
							Toggle(
								item.name,
								isOn: Binding(
									get: {
										jargon.name == item.name
									},
									set: { selected in
										if selected {
											jargon = item
										}
									}
								)
							)
						}
					} label: {
						Label("Jargon", systemImage: "character.book.closed")
					}
				}

				ToolbarItem(placement: .primaryAction) {
					if let exportURL {
						ShareLink(
							item: exportURL,
							preview: SharePreview(
								"\(character.person.identity.name) Character Sheet",
								image: Image(systemName: "doc.richtext")
							)
						) {
							Label("Export PDF", systemImage: "square.and.arrow.up")
						}
					}
				}
			}
		}
		.task(id: character.person.identity.name) {
			generatePDF()
		}
		.onChange(of: character.person.identity.name) { _, _ in
			generatePDF()
		}
		.onChange(of: theme.name) { _, _ in
			generatePDF()
		}
		.onChange(of: sheet.name) { _, _ in
			generatePDF()
		}
		.onChange(of: jargon.name) { _, _ in
			generatePDF()
		}
	}

	@MainActor
	private func generatePDF() {
		let generator = PDFGenerator()
		let generated = generator.form(SheetRender(theme: theme, character: character, jargon: jargon, pages: sheet.pages)) {
			SheetRender.background(theme, $0)
		}
		do {
			guard let document = generated.1 else {
				throw CharacterSheetViewError.invalidPDFData
			}

			let directory = FileManager.default.temporaryDirectory
				.appendingPathComponent("AshCharacterSheetExports", isDirectory: true)
			try FileManager.default.createDirectory(
				at: directory,
				withIntermediateDirectories: true
			)

			let safeName = exportFileName.replacingOccurrences(of: "/", with: "-")
			let url = directory.appendingPathComponent(safeName)
			try generated.0.write(to: url, options: .atomic)

			pdfDocument = document
			exportURL = url
			errorMessage = nil
		} catch {
			pdfDocument = nil
			exportURL = nil
			errorMessage = error.localizedDescription
		}
	}
}

private enum CharacterSheetViewError: LocalizedError {
	case invalidPDFData

	var errorDescription: String? {
		switch self {
		case .invalidPDFData:
			return "PDFKit could not open the generated PDF data."
		}
	}
}

#Preview("Ash PDF") {
	CharacterSheetPDFView()
}
