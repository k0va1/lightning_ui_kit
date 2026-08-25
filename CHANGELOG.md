# Changelog

## [0.4.2](https://github.com/k0va1/lightning_ui_kit/compare/v0.4.1...v0.4.2) (2026-08-25)


### Features

* **alert:** animate dismissal and use a pointer cursor on the close button ([99884e8](https://github.com/k0va1/lightning_ui_kit/commit/99884e8987fc5122a0cd3aa9f729c0ff86586012))
* **alert:** dismissible close button and autodismiss ([f680820](https://github.com/k0va1/lightning_ui_kit/commit/f680820dab7d444cd87bd52e0dfe8febc3a65a54))


### Bug Fixes

* **alert:** keep inline content as one shrinkable flex item ([b970676](https://github.com/k0va1/lightning_ui_kit/commit/b970676deb39199daa354c17d0a4e80c7ec3b88f))
* **chart:** hide x labels that collide at the rendered width ([cde621f](https://github.com/k0va1/lightning_ui_kit/commit/cde621f0044927a96d11394a3fce84cdab8e39c2))
* **chart:** size the y gutter to its labels and anchor edge x labels inward ([0958c73](https://github.com/k0va1/lightning_ui_kit/commit/0958c73e9c3cc886acada896772a05d2efea1501))
* **chart:** stretch to the container width without distortion ([118f441](https://github.com/k0va1/lightning_ui_kit/commit/118f4418156d7520b142237eefed8921dcb50ddf))
* **copy_input:** keep the secret value after a Turbo cache restore ([a8931c7](https://github.com/k0va1/lightning_ui_kit/commit/a8931c7efe5b7785d4b7639b862377ef3a339ec3))

## [0.4.1](https://github.com/k0va1/lightning_ui_kit/compare/v0.4.0...v0.4.1) (2026-08-21)


### Features

* **chart:** value formatting, label thinning, y-domain control and nil gaps ([ec308cf](https://github.com/k0va1/lightning_ui_kit/commit/ec308cf51c7002274b44adc5e0444c90e3bfe32d))


### Bug Fixes

* **description_list:** wrap long values instead of overflowing the container ([8455740](https://github.com/k0va1/lightning_ui_kit/commit/8455740a92cffeb6bbfdaecb9719c5a588a34272))
* **lookbook:** sync Gemfile.lock with the 0.4.0 path gem ([ce77e9a](https://github.com/k0va1/lightning_ui_kit/commit/ce77e9a44a7a64dfeba1a1fbe89fbd8796587f52))
* **table:** render non-String cell values instead of blank cells ([b2d30b6](https://github.com/k0va1/lightning_ui_kit/commit/b2d30b671ed1c2f8cd02472125971a13db157720))
* **table:** scroll horizontally instead of overflowing the container ([36048a7](https://github.com/k0va1/lightning_ui_kit/commit/36048a71a73f8962473658ffb9ec1171cea9ecb0))
* use gem-prefixed --lui-radius-lg theme variable ([adc2c3e](https://github.com/k0va1/lightning_ui_kit/commit/adc2c3eb268d9c9338f41859064c4812af04b760))

## [0.4.0](https://github.com/k0va1/lightning_ui_kit/compare/v0.3.5...v0.4.0) (2026-08-04)


### ⚠ BREAKING CHANGES

* AlertDialogComponent, the lui.alert_dialog helper and the lui-alert-dialog controller are removed; use ModalComponent.new(variant: :alert) and the lui-modal:confirm event.

### Features

* add CopyInputComponent with secret mode ([fb54a02](https://github.com/k0va1/lightning_ui_kit/commit/fb54a02e96e3b2d700a05b78d5b6a1210fd738ff))
* add selection, bulk actions, and server-side sorting to table ([69c1557](https://github.com/k0va1/lightning_ui_kit/commit/69c1557ebd553f6ad5c72a0e6529e2371696b009))
* more components ([#83](https://github.com/k0va1/lightning_ui_kit/issues/83)) ([5c3af78](https://github.com/k0va1/lightning_ui_kit/commit/5c3af78db9c5886c1c826fcb45af067e6bf4a021))


### Bug Fixes

* add word-break to table cells to prevent overflow ([2a59284](https://github.com/k0va1/lightning_ui_kit/commit/2a5928493704430616914d8238199d3f4cfc3105))
* apply disabled opacity to input component ([44942dc](https://github.com/k0va1/lightning_ui_kit/commit/44942dceebc41951cf7260c4d657af53fb7b88e2))
* optically align outline button height with solid buttons ([689ec4a](https://github.com/k0va1/lightning_ui_kit/commit/689ec4a0a6d9efcef8e2cb87d7180813cf7b07d0))
* pagination uniform sizing and mobile layout ([3826a77](https://github.com/k0va1/lightning_ui_kit/commit/3826a7750eddbeffbd525407dbacf150d25ffde9))
* prevent table cell layout break from flex on actions td ([c4086c8](https://github.com/k0va1/lightning_ui_kit/commit/c4086c821ec71334c49f8a3663077bc84e4a0b6a))

## [0.3.5](https://github.com/k0va1/lightning_ui_kit/compare/v0.3.4...v0.3.5) (2026-05-01)


### Bug Fixes

* body padding ([40e8a22](https://github.com/k0va1/lightning_ui_kit/commit/40e8a223c269d7f4206586fbf1355ab18c333266))
* small button sizing, icon alignment, and dependency upgrades ([707ae6a](https://github.com/k0va1/lightning_ui_kit/commit/707ae6a2007501613a86b1f7225ff4a680af6093))
* theme switcher ([9bd5f3a](https://github.com/k0va1/lightning_ui_kit/commit/9bd5f3a9217574e87deca92f6b44839e0089328a))
* upgrade Tailwind CSS to v4.2 and fix pagination arrow sizing ([2c918da](https://github.com/k0va1/lightning_ui_kit/commit/2c918dab6a4164240fed22bc1d81af7d8c2a8c5a))

## [0.3.4](https://github.com/k0va1/lightning_ui_kit/compare/v0.3.3...v0.3.4) (2026-02-23)


### Features

* add Card, Accordion, Tabs, and RadioGroup components ([8ebf0f5](https://github.com/k0va1/lightning_ui_kit/commit/8ebf0f534f0f4b5c3754a933f0588ccf758ae5eb))
* redesign layout with frosted glass sidebar and page background ([#70](https://github.com/k0va1/lightning_ui_kit/issues/70)) ([53b4432](https://github.com/k0va1/lightning_ui_kit/commit/53b44328db74bac76e73e2442d6372c951a66b0d))


### Bug Fixes

* redesign banner component with shadcn alert pattern and add lookbook theme toggle ([6935997](https://github.com/k0va1/lightning_ui_kit/commit/69359978608c9f034084e0d5d169b9252a6e3b7e))
* update css ([458cd4f](https://github.com/k0va1/lightning_ui_kit/commit/458cd4f383083204d65ab039189141f03ee1926b))

## [0.3.3](https://github.com/k0va1/lightning_ui_kit/compare/v0.3.2...v0.3.3) (2026-02-19)


### Bug Fixes

* release assets ([e13fc7b](https://github.com/k0va1/lightning_ui_kit/commit/e13fc7b186ebdf2028ef8a9d81400fc9e1ff2c60))

## [0.3.2](https://github.com/k0va1/lightning_ui_kit/compare/v0.3.1...v0.3.2) (2026-02-19)


### Features

* add CSS custom property theming system with light/dark themes ([429448c](https://github.com/k0va1/lightning_ui_kit/commit/429448c036fbb1a1f45c26bf7af1d2738825a04f))
* add pagination params forwarding and sidebar icon bounce animation ([f088e84](https://github.com/k0va1/lightning_ui_kit/commit/f088e84aa5aa51fbb8eaad19df163775f33b6662))


### Bug Fixes

* improve badge visibility in dark mode ([f96f5c2](https://github.com/k0va1/lightning_ui_kit/commit/f96f5c23f22c66f66448dd01887585c2be921316))
* improve dark theme surface hierarchy for layout and components ([4591c2a](https://github.com/k0va1/lightning_ui_kit/commit/4591c2a4d83d9a3d92dd36909df5e00ccb4624a8))
* improve layout sidebar link styles and use semantic tokens ([0c0e859](https://github.com/k0va1/lightning_ui_kit/commit/0c0e859ea46179c2ba526b8f406a1391af3bd679))
* make pagination arrow hover state square with aspect-square ([c5e1a5f](https://github.com/k0va1/lightning_ui_kit/commit/c5e1a5fd9acfabdee3df7843cc3b2ee0b4d92fbb))

## [0.3.1](https://github.com/k0va1/lightning_ui_kit/compare/v0.2.5...v0.3.1) (2026-01-25)


### Features

* add lui helper for convenient component rendering ([d9500e1](https://github.com/k0va1/lightning_ui_kit/commit/d9500e10cbc351e38006309e73500690452f9fee))
* **forms:** add automatic label generation for form components ([0a96d94](https://github.com/k0va1/lightning_ui_kit/commit/0a96d94fca325762132c33771d13eb7e86808023))
* **lookbook:** add configurable body padding for previews ([b03ea2c](https://github.com/k0va1/lightning_ui_kit/commit/b03ea2c36dfe4782d907765c9c2a8b2e3f08a176))


### Bug Fixes

* **switch:** use event.currentTarget for reliable toggle ([6731152](https://github.com/k0va1/lightning_ui_kit/commit/6731152b05028880a460c8f61e90354f26abb115))

## [0.2.5](https://github.com/k0va1/lightning_ui_kit/compare/v0.2.4...v0.2.5) (2026-01-18)


### Features

* input component improvements ([#60](https://github.com/k0va1/lightning_ui_kit/issues/60)) ([7490f8d](https://github.com/k0va1/lightning_ui_kit/commit/7490f8da700d51df6e4d73fdafa9118982466657))

## [0.2.4](https://github.com/k0va1/lightning_ui_kit/compare/v0.2.3...v0.2.4) (2026-01-18)


### Features

* add combobox component ([#58](https://github.com/k0va1/lightning_ui_kit/issues/58)) ([df7530e](https://github.com/k0va1/lightning_ui_kit/commit/df7530e41630e32d55f1875e897f77bcc557780d))
* add date type support to input component ([5a87b59](https://github.com/k0va1/lightning_ui_kit/commit/5a87b59bbedfd2d575af1cdcf8bd198c39d2f853))
* add layout component ([#55](https://github.com/k0va1/lightning_ui_kit/issues/55)) ([d856314](https://github.com/k0va1/lightning_ui_kit/commit/d85631407d801b43b91878f7d1c14c24267a93d0))
* add nested attributes support to combobox component ([d7deb9f](https://github.com/k0va1/lightning_ui_kit/commit/d7deb9f73104ca9a789d3bd1b47e07b560d69c15))
* sidebar improvements & minor bug fixes ([#59](https://github.com/k0va1/lightning_ui_kit/issues/59)) ([222e0d5](https://github.com/k0va1/lightning_ui_kit/commit/222e0d50175c251bd475389befaa443db70bb912))
* tooltip component ([#42](https://github.com/k0va1/lightning_ui_kit/issues/42)) ([d495921](https://github.com/k0va1/lightning_ui_kit/commit/d495921891f8bf487b1400e457f2baa5b8c25646))


### Bug Fixes

* align dropzone component colors with project color scheme ([1f019cf](https://github.com/k0va1/lightning_ui_kit/commit/1f019cf5b34521e5fcb1cbb2595743b878defce1))
* dropdown bugs ([#41](https://github.com/k0va1/lightning_ui_kit/issues/41)) ([6072882](https://github.com/k0va1/lightning_ui_kit/commit/60728820fc33fb6163f4d7d5d140dd49d56f8386))
* file input overlow ([f76c4aa](https://github.com/k0va1/lightning_ui_kit/commit/f76c4aaf133a0ea4a5ad1683ddda439bf7f87e62))
* prod assets ([acce06a](https://github.com/k0va1/lightning_ui_kit/commit/acce06a280577bd58601fee1faebe001abb049b0))
* prod assets v2 ([9eb13d7](https://github.com/k0va1/lightning_ui_kit/commit/9eb13d7b3bd8967f36f6bf9e683b7019530090bb))
* prod assets v3 ([3ebd4a5](https://github.com/k0va1/lightning_ui_kit/commit/3ebd4a57ac3604a6ce582a3c09d94bb6aa9caf7a))
* prod assets v4 ([bf6e4a7](https://github.com/k0va1/lightning_ui_kit/commit/bf6e4a78aed4d615013a5b27dc44f2034f640822))
* set checkbox control according to value ([#27](https://github.com/k0va1/lightning_ui_kit/issues/27)) ([bd5956f](https://github.com/k0va1/lightning_ui_kit/commit/bd5956f3ceb16dd1ff8a7ef1a1b31459eb6afdbb))
* use [@checked](https://github.com/checked) ([e2bb92c](https://github.com/k0va1/lightning_ui_kit/commit/e2bb92cc4c92b51aaa7f9e6e072ebf40d12fbda1))
* value is not needed for form ([2c5b4b4](https://github.com/k0va1/lightning_ui_kit/commit/2c5b4b4331c76a7badea5f0738f2e1261658aab6))
