module LightningUiKit
  class Builder
    def initialize(view_context)
      @view_context = view_context
    end

    def accordion(*, **, &block)
      render(AccordionComponent.new(*, **), &block)
    end

    def alert(*, **, &block)
      render(AlertComponent.new(*, **), &block)
    end

    def alert_dialog(*, **, &block)
      render(AlertDialogComponent.new(*, **), &block)
    end

    def aspect_ratio(*, **, &block)
      render(AspectRatioComponent.new(*, **), &block)
    end

    def auth_layout(*, **, &block)
      render(AuthLayoutComponent.new(*, **), &block)
    end

    def avatar(*, **, &block)
      render(AvatarComponent.new(*, **), &block)
    end

    def badge(*, **, &block)
      render(BadgeComponent.new(*, **), &block)
    end

    def breadcrumb(*, **, &block)
      render(BreadcrumbComponent.new(*, **), &block)
    end

    def button(*, **, &block)
      render(ButtonComponent.new(*, **), &block)
    end

    def calendar(*, **, &block)
      render(CalendarComponent.new(*, **), &block)
    end

    def card(*, **, &block)
      render(CardComponent.new(*, **), &block)
    end

    def carousel(*, **, &block)
      render(CarouselComponent.new(*, **), &block)
    end

    def chart(*, **, &block)
      render(ChartComponent.new(*, **), &block)
    end

    def checkbox(*, **, &block)
      render(CheckboxComponent.new(*, **), &block)
    end

    def collapsible(*, **, &block)
      render(CollapsibleComponent.new(*, **), &block)
    end

    def combobox(*, **, &block)
      render(ComboboxComponent.new(*, **), &block)
    end

    def command(*, **, &block)
      render(CommandComponent.new(*, **), &block)
    end

    def context_menu(*, **, &block)
      render(ContextMenuComponent.new(*, **), &block)
    end

    def copy_input(*, **, &block)
      render(CopyInputComponent.new(*, **), &block)
    end

    def date_picker(*, **, &block)
      render(DatePickerComponent.new(*, **), &block)
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

    def hover_card(*, **, &block)
      render(HoverCardComponent.new(*, **), &block)
    end

    def input(*, **, &block)
      render(InputComponent.new(*, **), &block)
    end

    def input_otp(*, **, &block)
      render(InputOtpComponent.new(*, **), &block)
    end

    def layout(*, **, &block)
      render(LayoutComponent.new(*, **), &block)
    end

    def link(*, **, &block)
      render(LinkComponent.new(*, **), &block)
    end

    def menubar(*, **, &block)
      render(MenubarComponent.new(*, **), &block)
    end

    def modal(*, **, &block)
      render(ModalComponent.new(*, **), &block)
    end

    def navigation_menu(*, **, &block)
      render(NavigationMenuComponent.new(*, **), &block)
    end

    def pagination(*, **, &block)
      render(PaginationComponent.new(*, **), &block)
    end

    def popover(*, **, &block)
      render(PopoverComponent.new(*, **), &block)
    end

    def progress(*, **, &block)
      render(ProgressComponent.new(*, **), &block)
    end

    def radio_group(*, **, &block)
      render(RadioGroupComponent.new(*, **), &block)
    end

    def resizable(*, **, &block)
      render(ResizableComponent.new(*, **), &block)
    end

    def select(*, **, &block)
      render(SelectComponent.new(*, **), &block)
    end

    def scroll_area(*, **, &block)
      render(ScrollAreaComponent.new(*, **), &block)
    end

    def separator(*, **, &block)
      render(SeparatorComponent.new(*, **), &block)
    end

    def sheet(*, **, &block)
      render(SheetComponent.new(*, **), &block)
    end

    def slider(*, **, &block)
      render(SliderComponent.new(*, **), &block)
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

    def tabs(*, **, &block)
      render(TabsComponent.new(*, **), &block)
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

    def toggle(*, **, &block)
      render(ToggleComponent.new(*, **), &block)
    end

    def toggle_group(*, **, &block)
      render(ToggleGroupComponent.new(*, **), &block)
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
