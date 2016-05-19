object frmWordmarks: TfrmWordmarks
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 250
  BorderStyle = bsNone
  Caption = 'Shadhin Ovidhan | WORDMARKS'
  ClientHeight = 240
  ClientWidth = 175
  Color = 15132390
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sBtnAdd: TSpeedButton
    Left = 8
    Top = 22
    Width = 75
    Height = 20
    Caption = 'Add'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = 13395456
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = sBtnAddClick
  end
  object sBtnRemove: TSpeedButton
    Left = 92
    Top = 22
    Width = 75
    Height = 20
    Caption = 'Remove'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = 13395456
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = sBtnRemoveClick
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 175
    Height = 15
    Cursor = crSizeAll
    Align = alTop
    BevelOuter = bvNone
    Color = 6579300
    ParentBackground = False
    TabOrder = 0
    OnMouseDown = pnlHeaderMouseDown
  end
  object Panel2: TPanel
    Left = 0
    Top = 210
    Width = 175
    Height = 30
    Cursor = crSizeAll
    Align = alBottom
    BevelOuter = bvNone
    Color = 6579300
    ParentBackground = False
    TabOrder = 1
    OnMouseDown = pnlHeaderMouseDown
    ExplicitTop = 211
    object btnClose: TButton
      Left = 92
      Top = 5
      Width = 75
      Height = 20
      Caption = 'Okay'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnSaveToFile: TButton
      Left = 8
      Top = 5
      Width = 75
      Height = 20
      Caption = 'Save to File'
      TabOrder = 1
      OnClick = btnSaveToFileClick
    end
  end
  object JvLstBoxWM: TJvListBox
    Left = 8
    Top = 48
    Width = 159
    Height = 153
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    IntegralHeight = True
    ItemHeight = 17
    SelectedColor = 15790320
    SelectedTextColor = clBlack
    ShowFocusRect = False
    Background.FillMode = bfmTile
    Background.Visible = False
    ParentFont = False
    ScrollBars = ssVertical
    Sorted = True
    Style = lbOwnerDrawFixed
    TabOrder = 2
  end
  object SaveDlgWM: TSaveDialog
    Filter = 'Text Documents|*.txt'
    Left = 56
    Top = 136
  end
end
