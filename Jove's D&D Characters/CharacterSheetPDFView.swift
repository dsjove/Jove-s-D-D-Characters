import SwiftUI
import PDFKit
import SBJLayout

//TODO: make generic
public struct CharacterSheetPDFView: View {
    // Persist last selections between launches
    @AppStorage("CharacterSheetPDFView.selectedCharacterName") private var storedCharacterName: String = Characters.first!.person.identity.name
    @AppStorage("CharacterSheetPDFView.selectedThemeName") private var storedThemeName: String = Themes.first!.name
    @AppStorage("CharacterSheetPDFView.selectedSheetName") private var storedSheetName: String = Sheets.first!.name
    @AppStorage("CharacterSheetPDFView.selectedJargonName") private var storedJargonName: String = Jargons.first!.name

	@State private var character: Character = Characters.first!
	@State private var theme: Theme = Themes.first!
	@State private var sheet: Sheet = Sheets.first!
	@State private var jargon: any Jargon = Jargons.first!

	@State private var pdfDocument: PDFDocument?
	@State private var exportURL: URL?
	@State private var errorMessage: String?

    @State private var pdfView: PDFView?
    @State private var canGoToPreviousPage: Bool = false
    @State private var canGoToNextPage: Bool = false
    @State private var pageChangedObserver: Any?
    @State private var documentChangedObserver: Any?

	public init() {
	}

	public var exportFileName: String {
		"\(character.person.identity.name)_Character_Sheet.pdf"
	}


	public var body: some View {
		NavigationStack {
			Group {
				if let pdfDocument {
#if canImport(UIKit)
                    PDFViewRepresentable(document: pdfDocument) { view in
                        self.pdfView = view
                        self.updateCanGoStates()
                        // Register for page/document change notifications (no Combine)
                        self.pageChangedObserver = NotificationCenter.default.addObserver(forName: Notification.Name.PDFViewPageChanged, object: view, queue: .main) { _ in
                            self.updateCanGoStates()
                        }
                        self.documentChangedObserver = NotificationCenter.default.addObserver(forName: Notification.Name.PDFViewDocumentChanged, object: view, queue: .main) { _ in
                            self.updateCanGoStates()
                        }
                    }
#else
                    // Fallback to original if UIKit is not available
                    PDFKitView(document: pdfDocument)
#endif
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
        .onAppear {
            // Initialize selections from stored values on first appear
            if let foundCharacter = Characters.first(where: { $0.person.identity.name == storedCharacterName }) {
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
        .onDisappear {
            if let token = pageChangedObserver { NotificationCenter.default.removeObserver(token) }
            if let token = documentChangedObserver { NotificationCenter.default.removeObserver(token) }
            pageChangedObserver = nil
            documentChangedObserver = nil
        }
		.task(id: character.person.identity.name) {
			generatePDF()
		}
		.onChange(of: character.person.identity.name) { _, newValue in
			storedCharacterName = newValue
			generatePDF()
		}
		.onChange(of: theme.name) { _, newValue in
			storedThemeName = newValue
			generatePDF()
		}
		.onChange(of: sheet.name) { _, newValue in
			storedSheetName = newValue
			generatePDF()
		}
		.onChange(of: jargon.name) { _, newValue in
			storedJargonName = newValue
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

#if canImport(UIKit)
private struct PDFViewRepresentable: UIViewRepresentable {
    let document: PDFDocument
    let onCreated: (PDFView) -> Void

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
        view.displayMode = .singlePageContinuous
        view.displayDirection = .vertical
        view.displaysPageBreaks = true
        view.document = document
        onCreated(view)
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if uiView.document !== document {
            uiView.document = document
        }
    }
}
#endif

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

