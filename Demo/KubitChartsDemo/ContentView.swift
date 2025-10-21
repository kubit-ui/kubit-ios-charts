import KubitCharts
import SwiftUI

struct ContentView: View {
    @State private var groups: [ComponentGroup] = ComponentGroup.groups
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                VStack {
                    HStack {
                        icon
                        pageTitle
                    }
                    Divider()
                    textField
                }
                ForEach(filteredSections) { getSectionFor($0) }
            }
        }
    }
}

// MARK: - Inner Views
private extension ContentView {
    var icon: some View {
        let size = CGSize(width: 30, height: 30)
        return KImage(resource: KImage.LocalResource(name: "logo"))
            .size(size)
    }

    @ViewBuilder var pageTitle: some View {
        let title = "CHARTS"
        Text(title)
            .font(.caption)
            .fontWeight(.bold)
            .dynamicTypeSize(...DynamicTypeSize.large)
    }

    @ViewBuilder var textField: some View {
        TextField("Search your component...", text: $searchText)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            .font(.caption)
            .dynamicTypeSize(...DynamicTypeSize.medium)
    }

    func getSectionFor(_ group: ComponentGroup) -> some View {
        Section {
            ForEach(filteredComponents(group: group)) { getRowFor($0) }
        } header: {
            sectionHeader(group.name)
        }
    }

    @ViewBuilder
    func sectionHeader(_ name: String) -> some View {
        Text(name)
            .font(.caption)
            .dynamicTypeSize(...DynamicTypeSize.small)
    }

    @ViewBuilder
    func getRowFor(_ component: Component) -> some View {
        NavigationLink(component.name.uppercased()) {
            componentView(component)
        }
        .font(.caption)
        .dynamicTypeSize(...DynamicTypeSize.medium)
    }

    func componentView(_ component: Component) -> some View {
        let view = component.view
            .navigationBarTitle(component.name.uppercased())
        return AnyView(view)
    }
}

// MARK: - Private
private extension ContentView {
    var filteredSections: [ComponentGroup] {
        groups.filter(sectionsFilter(_:))
    }

    func filteredComponents(group: ComponentGroup) -> [Component] {
        group.components.filter(componentsFilter(_:))
    }

    func componentsFilter(_ component: Component) -> Bool {
        searchText.isEmpty ? true : component.name.localizedCaseInsensitiveContains(searchText)
    }

    func sectionsFilter(_ group: ComponentGroup) -> Bool {
        if searchText.isEmpty {
            return true
        }
        return !group.components.filter(componentsFilter(_:)).isEmpty
    }
}

#Preview {
    ContentView()
}
