#include QMK_KEYBOARD_H

enum layer_names {
    _BASE,
    _NAV,
    _SYM,
    _FN
};

// Define the custom macro
enum custom_keycodes {
    HELLO_WORLD = SAFE_RANGE, // Start custom keycodes after the safe range
    AUTH_ROOT // Added AUTH_ROOT to the custom keycodes
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT_split_4x6_3(
    /*
    [_BASE] = LAYOUT_split_4x6_3(
    ┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
    │ ESC  │  1   │  2   │  3   │  4   │  5   │                │  6   │  7   │  8   │  9   │  0   │ BSPC │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │ TAB  │  Q   │  W   │  E   │  R   │  T   │                │  Y   │  U   │  I   │  O   │  P   │  [   │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │ LCTL │ A/GUI│S/ALT │D/SHFT│F/CTL │  G   │                │  H   │J/CTL │K/SHFT│L/ALT │;/GUI │  '   │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │ LSFT │  Z   │  X   │  C   │  V   │  B   │                │  N   │  M   │  ,   │  .   │  /   │ ENT  │
    └──────┴──────┴──────┴──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┴──────┴──────┴──────┘
                                │ LGUI │ NAV  │ SPC  │  │ SPC  │ SYM  │ RALT │
                                └──────┴──────┴──────┘  └──────┴──────┴──────┘
    */
    [_BASE] = LAYOUT_split_4x6_3(
        KC_ESC,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                               KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
        KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                               KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_LBRC,
        KC_LCTL, MT(MOD_LGUI, KC_A), MT(MOD_LALT, KC_S), MT(MOD_LSFT, KC_D), MT(MOD_LCTL, KC_F),    KC_G,                               KC_H,    MT(MOD_RCTL, KC_J), MT(MOD_RSFT, KC_K), MT(MOD_LALT, KC_L), MT(MOD_RGUI, KC_SCLN), KC_QUOT,
        KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                               KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_ENT,
                                            KC_LGUI, MO(_NAV), KC_SPC,           KC_SPC,  MO(_SYM), KC_RALT
    ),
    /*
    [_NAV] = LAYOUT_split_4x6_3(
    ┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
    │  `   │  F1  │  F2  │  F3  │  F4  │  F5  │                │  F6  │  F7  │  F8  │  F9  │ F10  │ DEL  │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │ HOME │ PGDN │ PGUP │ END  │      │  ]   │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │  AR  │      │      │      │      │                │ LEFT │ DOWN │  UP  │ RIGHT│      │      │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │      │      │      │      │      │      │
    └──────┴──────┴──────┴──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┴──────┴──────┴──────┘
                                │      │      │      │  │      │      │      │
                                └──────┴──────┴──────┘  └──────┴──────┴──────┘
    */
    [_NAV] = LAYOUT_split_4x6_3(
        KC_GRV,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                              KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_DEL,
        _______, _______, _______, _______, _______, _______,                            KC_HOME, KC_PGDN, KC_PGUP, KC_END,  _______, KC_RBRC,
        _______, AUTH_ROOT, _______, _______, _______, _______,                            KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, _______, _______,
        _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
                                            _______, _______, _______,          _______, _______, _______
    ),
    /*
    [_SYM] = LAYOUT_split_4x6_3(
    ┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
    │  ~   │  !   │  @   │  #   │  $   │  %   │                │  ^   │  &   │  *   │  (   │  )   │ DEL  │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │  -   │  =   │  {   │  }   │  |   │  \   │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │  _   │  +   │  [   │  ]   │  :   │  "   │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │      │      │      │      │  ?   │      │
    └──────┴──────┴──────┴──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┴──────┴──────┴──────┘
                                │      │      │      │  │      │      │      │
                                └──────┴──────┴──────┘  └──────┴──────┴──────┘
    */
    [_SYM] = LAYOUT_split_4x6_3(
        KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                            KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_DEL,
        _______, _______, _______, _______, _______, _______,                            KC_MINS, KC_EQL,  KC_LCBR, KC_RCBR, KC_PIPE, KC_BSLS,
        _______, _______, _______, _______, _______, _______,                            KC_UNDS, KC_PLUS, KC_LBRC, KC_RBRC, KC_COLN, KC_DQUO,
        _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, KC_QUES, _______,
                                            _______, _______, _______,          _______, _______, _______
    ),
    /*
    [_FN] = LAYOUT_split_4x6_3(
    ┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
    │ BOOT │      │      │      │      │      │                │      │      │      │      │      │      │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │      │      │      │      │      │      │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │      │      │      │      │      │      │
    ├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
    │      │      │      │      │      │      │                │      │      │      │      │      │      │
    └──────┴──────┴──────┴──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┴──────┴──────┴──────┘
                                │      │      │      │  │      │      │      │
                                └──────┴──────┴──────┘  └──────┴──────┴──────┘
    */
    [_FN] = LAYOUT_split_4x6_3(
        QK_BOOT, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, HELLO_WORLD,                        _______, _______, _______, _______, _______, _______,
                                            _______, _______, _______,          _______, _______, _______
    )
};

// Process the custom macro
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case HELLO_WORLD:
            if (record->event.pressed) {
                SEND_STRING("Hello, World!" SS_TAP(X_ENTER));
            }
            return false;
        case AUTH_ROOT:
            if (record->event.pressed) {
                SEND_STRING("root password" SS_TAP(X_ENTER));
            }
            return false;
    }
    return true;
}
