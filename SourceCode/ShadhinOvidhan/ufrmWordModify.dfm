object frmWordModify: TfrmWordModify
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Shadhin Ovidhan | Add/Modify Meaning'
  ClientHeight = 350
  ClientWidth = 350
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Nirmala UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object Shape1: TShape
    Left = 0
    Top = 309
    Width = 350
    Height = 41
    Align = alBottom
    Brush.Color = 15658734
    Pen.Style = psClear
    ExplicitTop = 154
    ExplicitWidth = 341
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 124
    Height = 17
    Caption = #2439#2434#2480#2503#2460#2495' '#2486#2476#2509#2470'/ '#2486#2476#2509#2470' '#2455#2497#2458#2509#2459
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 165
    Width = 72
    Height = 17
    Caption = #2437#2480#2509#2469' ('#2438#2478#2494#2480')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 66
    Width = 82
    Height = 17
    Caption = #2437#2480#2509#2469' ('#2437#2477#2495#2471#2494#2472')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 261
    Width = 334
    Height = 45
    AutoSize = False
    Caption = 
      #2470#2509#2480#2487#2509#2463#2476#2509#2479#2435' '#2437#2480#2509#2469' '#2482#2503#2454#2494#2480' '#2488#2478#2527' "'#2404' ('#2470#2494#2524#2495')" '#2476#2509#2479#2476#2489#2494#2480' '#2472#2494' '#2453#2480#2503' '#2486#2476#2509#2470' '#2455#2497#2482#2507' ";' +
      ' (semi-colon)" '#2458#2495#2489#2509#2472' '#2470#2495#2527#2503' '#2438#2482#2494#2470#2494' '#2453#2480#2503' '#2482#2495#2454#2497#2472#2404
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2631720
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object pnlBtnSave: TPanel
    Left = 267
    Top = 317
    Width = 75
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = #2488#2434#2480#2453#2509#2487#2467
    Color = clWhite
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = pnlBtnSaveClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
  object pnlBtnCancel: TPanel
    Left = 8
    Top = 317
    Width = 75
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = #2476#2494#2468#2495#2482
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = pnlBtnCancelClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
  object eWord: TEdit
    Left = 8
    Top = 31
    Width = 330
    Height = 29
    Cursor = crArrow
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object memoMeaning: TMemo
    Left = 8
    Top = 89
    Width = 330
    Height = 70
    Cursor = crArrow
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object memoAdMeaning: TMemo
    Left = 8
    Top = 188
    Width = 330
    Height = 70
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnKeyPress = memoAdMeaningKeyPress
    OnKeyUp = memoAdMeaningKeyUp
  end
end
