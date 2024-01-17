//
//  PillTagView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct PillTag: Identifiable, Hashable {
    var id = UUID()
    var text: String
}

/**
 * A Pill view that displays clickable pills.  When pills don't fit horizontally they move to next line
 */
struct PillTagsView: View {
    let pillTags: [PillTag]
    @Binding var selectedTag: PillTag?
    @State private var totalHeight = CGFloat.zero  // Arbitrary initial value
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)  // Updates the frame height dynamically
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.pillTags, id: \.self) { pillTag in
                self.item(for: pillTag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if pillTag == self.pillTags.last {
                            width = 0 // last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if pillTag == self.pillTags.last {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func item(for pillTag: PillTag) -> some View {
        Text(pillTag.text)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(selectedTag == pillTag ? Color.btnEnabled : Color.gray.opacity(colorScheme == .dark ? 0.4 : 0.2))
            .foregroundColor(selectedTag == pillTag ? .white : .primary)
            .clipShape(Capsule())
            .onTapGesture {
                self.selectedTag = pillTag
            }
    }
    
    private func viewHeightReader(_ height: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                height.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    let pills = [
        PillTag(text: "All"),
        PillTag(text: "Fitness"),
        PillTag(text: "Daily"),
        PillTag(text: "Custom"),
        PillTag(text: "Item 1"),
        PillTag(text: "Item 2")
    ];

    return PillTagsView(
        pillTags: pills,
        selectedTag: .constant(pills[0])
    )
}
