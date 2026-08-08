import SwiftUI
import PDFKit
import SBJLayout

//TODO: make generic
public struct CharacterSheetPDFView: View {
	@AppStorage("CharacterSheetPDFView.selectedCharacterID") private var storedCharacterID: String = BigGuy.id
	@AppStorage("CharacterSheetPDFView.selectedThemeName") private var storedThemeName: String = BasicTheme().name
	@AppStorage("CharacterSheetPDFView.selectedSheetName") private var storedSheetName: String = BasicSheet.name
	@AppStorage("CharacterSheetPDFView.selectedJargonName") private var storedJargonName: String = BasicJargon().name

	@State private var character: Character = BigGuy
	@State private var theme: Theme = BasicTheme()
	@State private var sheet: Sheet = BasicSheet
	@State private var jargon: any Jargon = BasicJargon()

	@State private var pdfDocument: PDFDocument?
	@State private var exportURL: URL?
	@State private var jsonExportURL: URL?
	@State private var errorMessage: String?

	@State private var pdfView: PDFView?
	@State private var canGoToPreviousPage: Bool = false
	@State private var canGoToNextPage: Bool = false

	public init() {
	}

	public var exportFileName: String {
		let baseName = character.person.identity.name.isEmpty ? "Empty_Guy" : character.person.identity.name
		return "\(baseName)_Character_Sheet.pdf"
	}

	public var body: some View {
		NavigationStack {
			Group {
				if let pdfDocument {
					PDFViewRepresentable(document: pdfDocument) { view in
						self.pdfView = view
						self.updateCanGoStates()
					}
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
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						pdfView?.goToFirstPage(nil)
						updateCanGoStates()
					} label: {
						Label("First Page", systemImage: "backward.end")
					}
					.disabled(!canGoToPreviousPage)
				}

				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						pdfView?.goToPreviousPage(nil)
						updateCanGoStates()
					} label: {
						Label("Previous Page", systemImage: "chevron.left")
					}
					.disabled(!canGoToPreviousPage)
				}

				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						pdfView?.goToNextPage(nil)
						updateCanGoStates()
					} label: {
						Label("Next Page", systemImage: "chevron.right")
					}
					.disabled(!canGoToNextPage)
				}

				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						pdfView?.goToLastPage(nil)
						updateCanGoStates()
					} label: {
						Label("Last Page", systemImage: "forward.end")
					}
					.disabled(!canGoToNextPage)
				}

				ToolbarItem(placement: .primaryAction) {
					Menu {
						ForEach(Characters) { item in
							Toggle(
								item.person.identity.name.isEmpty ? "Empty Guy" : item.person.identity.name,
								isOn: Binding(
									get: {
										character.id == item.id
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

				ToolbarItem(placement: .primaryAction) {
					if let jsonExportURL {
						ShareLink(item: jsonExportURL) {
							Label("Export JSON", systemImage: "curlybraces")
						}
					}
				}
			}
		}
		.onAppear {
			// Initialize selections from stored values on first appear
			if let foundCharacter = Characters.first(where: { $0.id == storedCharacterID }) {
				character = foundCharacter
			}
			if let foundTheme = Themes.first(where: { $0.name == storedThemeName }) {
				theme = foundTheme
			}
			if let foundSheet = Sheets.first(where: { $0.name == storedSheetName }) {
				sheet = foundSheet
			}
			if let foundJargon = Jargons.first(where: { $0.name == storedJargonName }) {
				jargon = foundJargon
			}
		}
		.task(id: "\(character.id)|\(theme.name)|\(sheet.name)|\(jargon.name)") {
			generatePDF()
		}
		.onChange(of: character.id) { _, newValue in
			storedCharacterID = newValue
		}
		.onChange(of: theme.name) { _, newValue in
			storedThemeName = newValue
		}
		.onChange(of: sheet.name) { _, newValue in
			storedSheetName = newValue
		}
		.onChange(of: jargon.name) { _, newValue in
			storedJargonName = newValue
		}
	}

	@MainActor
	private func generatePDF() {
		let directory = FileManager.default.temporaryDirectory
			.appendingPathComponent("CharacterSheetExports", isDirectory: true)

		do {
			try FileManager.default.createDirectory(
				at: directory,
				withIntermediateDirectories: true
			)
			let baseName = character.person.identity.name.isEmpty ? "Empty_Guy" : character.person.identity.name
			let jsonURL = directory.appendingPathComponent("\(baseName)_Character.json".replacingOccurrences(of: "/", with: "-"))
			try CharacterJSONExporter.write(character, to: jsonURL)
			jsonExportURL = jsonURL
		} catch {
			jsonExportURL = nil
		}

		guard sheet.pages.contains(where: { !$0.isEmpty(character) }) else {
			pdfDocument = nil
			exportURL = nil
			errorMessage = CharacterSheetViewError.noRenderablePages.localizedDescription
			return
		}

		let generated = sheet.render(theme, character, jargon)
		do {
			guard let document = generated.1 else {
				throw CharacterSheetViewError.invalidPDFData
			}

			let safeName = exportFileName.replacingOccurrences(of: "/", with: "-")
			let url = directory.appendingPathComponent(safeName)
			try generated.0.write(to: url, options: .atomic)

			pdfDocument = document
			exportURL = url
			errorMessage = nil
			DispatchQueue.main.async { self.updateCanGoStates() }
		} catch {
			pdfDocument = nil
			exportURL = nil
			errorMessage = error.localizedDescription
		}
	}

	private func updateCanGoStates() {
		guard let pdfView, let document = pdfView.document, let current = pdfView.currentPage else {
			canGoToPreviousPage = false
			canGoToNextPage = false
			return
		}
		let index = document.index(for: current)
		canGoToPreviousPage = index > 0
		canGoToNextPage = index + 1 < document.pageCount
	}
}

private enum CharacterSheetViewError: LocalizedError {
	case invalidPDFData
	case noRenderablePages

	var errorDescription: String? {
		switch self {
		case .invalidPDFData:
			return "PDFKit could not open the generated PDF data."
		case .noRenderablePages:
			return "This character has no Basic Sheet content yet."
		}
	}
}

#Preview("Ash PDF") {
	CharacterSheetPDFView()
}
