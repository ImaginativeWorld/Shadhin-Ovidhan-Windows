object frmMeaningList: TfrmMeaningList
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Meaning List'
  ClientHeight = 300
  ClientWidth = 440
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Nirmala UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object List: TListView
    Left = 8
    Top = 8
    Width = 210
    Height = 243
    Columns = <
      item
        Caption = 'Word/ Phrase'
        Width = 200
      end>
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = ListSelectItem
  end
  object mMeaning: TMemo
    Left = 224
    Top = 8
    Width = 210
    Height = 193
    TabOrder = 1
    OnChange = mMeaningChange
    OnKeyPress = mMeaningKeyPress
  end
  object pnlDown: TPanel
    Left = 0
    Top = 257
    Width = 440
    Height = 43
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 15658734
    Font.Charset = ANSI_CHARSET
    Font.Color = 4934475
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object lblTotalEntries: TLabel
      Left = 8
      Top = 16
      Width = 83
      Height = 15
      Caption = #2478#2507#2463' '#2437#2472#2509#2468#2480#2509#2477#2497#2453#2509#2468#2495#2435' '
    end
    object pnlBtnOk: TPanel
      Left = 354
      Top = 10
      Width = 75
      Height = 25
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = #2476#2472#2509#2471
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = pnlBtnOkClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
    object pnlDelete: TPanel
      Left = 273
      Top = 10
      Width = 75
      Height = 25
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = #2478#2497#2459#2497#2472
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = pnlDeleteClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
  end
  object pnlBtnSave: TPanel
    Left = 224
    Top = 216
    Width = 210
    Height = 35
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = #2474#2480#2495#2476#2480#2509#2468#2472' '#2488#2434#2480#2453#2509#2487#2467' '#2453#2480#2497#2472
    Color = clWhite
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnClick = pnlBtnSaveClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
end
