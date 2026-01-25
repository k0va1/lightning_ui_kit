module LightningUiKit
  class Builder
    def initialize(view_context)
      @view_context = view_context
    end

    def alert(...)
      render(AlertComponent.new(...))
    end

    def avatar(...)
      render(AvatarComponent.new(...))
    end

    def badge(...)
      render(BadgeComponent.new(...))
    end

    def banner(...)
      render(BannerComponent.new(...))
    end

    def button(...)
      render(ButtonComponent.new(...))
    end

    def checkbox(...)
      render(CheckboxComponent.new(...))
    end

    def combobox(...)
      render(ComboboxComponent.new(...))
    end

    def description_list(...)
      render(DescriptionListComponent.new(...))
    end

    def dropdown(...)
      render(DropdownComponent.new(...))
    end

    def dropzone(...)
      render(DropzoneComponent.new(...))
    end

    def file_input(...)
      render(FileInputComponent.new(...))
    end

    def input(...)
      render(InputComponent.new(...))
    end

    def layout(...)
      render(LayoutComponent.new(...))
    end

    def link(...)
      render(LinkComponent.new(...))
    end

    def modal(...)
      render(ModalComponent.new(...))
    end

    def pagination(...)
      render(PaginationComponent.new(...))
    end

    def select(...)
      render(SelectComponent.new(...))
    end

    def sidebar(...)
      render(SidebarComponent.new(...))
    end

    def sidebar_link(...)
      render(SidebarLinkComponent.new(...))
    end

    def sidebar_section(...)
      render(SidebarSectionComponent.new(...))
    end

    def skeleton(...)
      render(SkeletonComponent.new(...))
    end

    def spinner(...)
      render(SpinnerComponent.new(...))
    end

    def switch(...)
      render(SwitchComponent.new(...))
    end

    def table(...)
      render(TableComponent.new(...))
    end

    def text(...)
      render(TextComponent.new(...))
    end

    def textarea(...)
      render(TextareaComponent.new(...))
    end

    def toast(...)
      render(ToastComponent.new(...))
    end

    def tooltip(...)
      render(TooltipComponent.new(...))
    end

    private

    def render(component, &block)
      @view_context.render(component, &block)
    end
  end
end
