module LightningUiKit
  class Builder
    def initialize(view_context)
      @view_context = view_context
    end

    def alert(*, **, &block)
      render(AlertComponent.new(*, **), &block)
    end

    def avatar(*, **, &block)
      render(AvatarComponent.new(*, **), &block)
    end

    def badge(*, **, &block)
      render(BadgeComponent.new(*, **), &block)
    end

    def banner(*, **, &block)
      render(BannerComponent.new(*, **), &block)
    end

    def button(*, **, &block)
      render(ButtonComponent.new(*, **), &block)
    end

    def checkbox(*, **, &block)
      render(CheckboxComponent.new(*, **), &block)
    end

    def combobox(*, **, &block)
      render(ComboboxComponent.new(*, **), &block)
    end

    def description_list(*, **, &block)
      render(DescriptionListComponent.new(*, **), &block)
    end

    def dropdown(*, **, &block)
      render(DropdownComponent.new(*, **), &block)
    end

    def dropzone(*, **, &block)
      render(DropzoneComponent.new(*, **), &block)
    end

    def file_input(*, **, &block)
      render(FileInputComponent.new(*, **), &block)
    end

    def input(*, **, &block)
      render(InputComponent.new(*, **), &block)
    end

    def layout(*, **, &block)
      render(LayoutComponent.new(*, **), &block)
    end

    def link(*, **, &block)
      render(LinkComponent.new(*, **), &block)
    end

    def modal(*, **, &block)
      render(ModalComponent.new(*, **), &block)
    end

    def pagination(*, **, &block)
      render(PaginationComponent.new(*, **), &block)
    end

    def select(*, **, &block)
      render(SelectComponent.new(*, **), &block)
    end

    def sidebar(*, **, &block)
      render(SidebarComponent.new(*, **), &block)
    end

    def sidebar_link(*, **, &block)
      render(SidebarLinkComponent.new(*, **), &block)
    end

    def sidebar_section(*, **, &block)
      render(SidebarSectionComponent.new(*, **), &block)
    end

    def skeleton(*, **, &block)
      render(SkeletonComponent.new(*, **), &block)
    end

    def spinner(*, **, &block)
      render(SpinnerComponent.new(*, **), &block)
    end

    def switch(*, **, &block)
      render(SwitchComponent.new(*, **), &block)
    end

    def table(*, **, &block)
      render(TableComponent.new(*, **), &block)
    end

    def text(*, **, &block)
      render(TextComponent.new(*, **), &block)
    end

    def textarea(*, **, &block)
      render(TextareaComponent.new(*, **), &block)
    end

    def toast(*, **, &block)
      render(ToastComponent.new(*, **), &block)
    end

    def tooltip(*, **, &block)
      render(TooltipComponent.new(*, **), &block)
    end

    private

    def render(component, &block)
      @view_context.render(component, &block)
    end
  end
end
