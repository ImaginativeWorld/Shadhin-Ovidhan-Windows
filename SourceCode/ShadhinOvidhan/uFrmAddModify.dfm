object frmAddModify: TfrmAddModify
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Shadhin Ovidhan | Entry Editor'
  ClientHeight = 521
  ClientWidth = 500
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Nirmala UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Shape1: TShape
    Left = 0
    Top = 480
    Width = 500
    Height = 41
    Align = alBottom
    Brush.Color = 15658734
    Pen.Style = psClear
    ExplicitTop = 250
    ExplicitWidth = 350
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 147
    Height = 21
    Caption = #2439#2434#2480#2503#2460#2495' '#2486#2476#2509#2470'/'#2486#2476#2509#2470#2455#2497#2458#2509#2459
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 23
    Height = 21
    Caption = #2474#2470
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 137
    Width = 26
    Height = 21
    Caption = #2437#2480#2509#2469
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 9
    Top = 265
    Width = 148
    Height = 21
    Caption = #2488#2478#2494#2480#2509#2469#2453' '#2486#2476#2509#2470' ('#2448#2458#2509#2459#2495#2453')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentFont = False
  end
  object pnlBtnSave: TPanel
    Left = 170
    Top = 490
    Width = 75
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = #2488#2478#2509#2474#2494#2470#2472
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
    OnClick = pnlBtnSaveClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
  object pnlBtnCancel: TPanel
    Left = 417
    Top = 489
    Width = 75
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = #2475#2495#2480#2503' '#2479#2494#2472
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
    OnClick = pnlBtnCancelClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
  object eWord: TEdit
    Left = 24
    Top = 35
    Width = 457
    Height = 25
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'eWord'
  end
  object mMeaning: TMemo
    Left = 24
    Top = 164
    Width = 457
    Height = 90
    Enabled = False
    Lines.Strings = (
      'mMeaning')
    ScrollBars = ssVertical
    TabOrder = 2
    OnChange = mMeaningChange
  end
  object ePOS: TEdit
    Left = 24
    Top = 99
    Width = 457
    Height = 25
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'ePOS'
  end
  object pnlBtnNew: TPanel
    Left = 8
    Top = 489
    Width = 75
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = '+ '#2472#2468#2497#2472
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    OnClick = pnlBtnNewClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
  object pnlBtnDel: TPanel
    Left = 89
    Top = 489
    Width = 75
    Height = 25
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = '- '#2478#2497#2459#2497#2472
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nirmala UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 7
    OnClick = pnlBtnDelClick
    OnMouseDown = pnlBtnMouseDown
    OnMouseEnter = pnlBtnMouseEnter
    OnMouseLeave = pnlBtnMouseLeave
    OnMouseUp = pnlBtnMouseUp
  end
  object pnlInfo: TPanel
    Left = 8
    Top = 362
    Width = 484
    Height = 49
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 8575982
    ParentBackground = False
    TabOrder = 8
    object PanelBG: TPanel
      Left = 1
      Top = 1
      Width = 482
      Height = 47
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = 16121343
      ParentBackground = False
      TabOrder = 0
      object lblInfo: TLabel
        Left = 5
        Top = 5
        Width = 472
        Height = 37
        Align = alClient
        Caption = 
          #2470#2509#2480#2487#2509#2463#2476#2509#2479#2435' '#2437#2480#2509#2469' '#2447#2476#2434' '#2488#2478#2494#2480#2509#2469#2453' '#2486#2476#2509#2470' '#2482#2495#2454#2494#2480' '#2453#2509#2487#2503#2468#2509#2480#2503' '#2474#2509#2480#2468#2495#2463#2495' '#2437#2480#2509#2469'/'#2488#2478#2494 +
          #2480#2509#2469#2453' '#2486#2476#2509#2470' '#2488#2503#2478#2495#2453#2507#2482#2472' (";") '#2476#2509#2479#2476#2489#2494#2480' '#2453#2480#2503' '#2438#2482#2494#2470#2494' '#2453#2480#2503' '#2482#2495#2454#2497#2472#2404' '#2441#2470#2494#2489#2480#2467#2435' "'#2488 +
          #2509#2476#2494#2471#2496#2472';'#2478#2497#2453#2509#2468'" '#2439#2468#2509#2479#2494#2470#2495#2404
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Nirmala UI'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 471
        ExplicitHeight = 34
      end
    end
  end
  object mSynonyms: TMemo
    Left = 25
    Top = 292
    Width = 457
    Height = 60
    Enabled = False
    Lines.Strings = (
      'mSynonyms')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object pnlCaution: TPanel
    Left = 8
    Top = 420
    Width = 484
    Height = 49
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 3092428
    ParentBackground = False
    TabOrder = 9
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 482
      Height = 47
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = 15921919
      ParentBackground = False
      TabOrder = 0
      object Label5: TLabel
        Left = 5
        Top = 5
        Width = 472
        Height = 37
        Align = alClient
        Caption = 
          #2437#2472#2509#2468#2480#2509#2477#2497#2453#2509#2468#2495' '#2479#2497#2453#2509#2468'/ '#2478#2497#2459#2494'/ '#2488#2478#2509#2474#2494#2470#2472' '#2453#2480#2494#2480' '#2474#2480#2503' '#2489#2494#2482#2472#2494#2455#2494#2470' '#2453#2480#2494' '#2475#2482#2494#2475#2482' '#2474#2503 +
          #2468#2503' '#2437#2476#2486#2509#2479#2439' '#2438#2476#2494#2480' '#2472#2468#2497#2472' '#2453#2480#2503' '#2437#2472#2497#2488#2472#2509#2471#2494#2472' '#2453#2480#2468#2503' '#2489#2476#2503#2404
        Color = 15921919
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Nirmala UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitHeight = 34
      end
    end
  end
end
