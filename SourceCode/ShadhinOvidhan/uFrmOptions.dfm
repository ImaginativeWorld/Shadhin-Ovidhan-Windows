object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Shadhin Ovidhan | Options'
  ClientHeight = 400
  ClientWidth = 450
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Nirmala UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pnlDown: TPanel
    Left = 0
    Top = 357
    Width = 450
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
    TabOrder = 0
    object lblVersion: TLabel
      Left = 5
      Top = 5
      Width = 91
      Height = 15
      Align = alLeft
      Caption = 'Shadhin Ovidhan'
      Layout = tlCenter
    end
    object pnlBtnOk: TPanel
      Left = 360
      Top = 10
      Width = 75
      Height = 25
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = #2464#2495#2453' '#2438#2459#2503
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
    object pnlBtnCancel: TPanel
      Left = 279
      Top = 10
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
      TabOrder = 1
      OnClick = btnCancelClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
    object pnlBtnReset: TPanel
      Left = 198
      Top = 10
      Width = 75
      Height = 25
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = #2474#2498#2472#2435#2488#2503#2463
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = btnResetClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 36
    Width = 433
    Height = 70
    Caption = #2441#2458#2509#2458#2494#2480#2467' '#2455#2468#2495
    TabOrder = 1
    object Label1: TLabel
      Left = 72
      Top = 27
      Width = 23
      Height = 21
      Caption = #2471#2496#2480
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 333
      Top = 27
      Width = 24
      Height = 21
      Caption = #2470#2509#2480#2497#2468
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object tBarSpRate: TTrackBar
      Left = 116
      Top = 27
      Width = 200
      Height = 30
      Max = 5
      Min = -5
      TabOrder = 0
    end
  end
  object chkClipboard: TCheckBox
    Left = 9
    Top = 8
    Width = 433
    Height = 17
    Caption = #2453#2509#2482#2495#2474#2476#2507#2480#2509#2465' '#2472#2460#2480' '#2480#2494#2454#2476#2503' ('#2486#2497#2471#2497' '#2470#2509#2480#2497#2468' '#2437#2472#2497#2488#2472#2509#2471#2494#2472#2503' '#2474#2509#2480#2479#2507#2460#2509#2479')'
    TabOrder = 2
  end
  object GroupBox2: TGroupBox
    Left = 9
    Top = 117
    Width = 433
    Height = 116
    Caption = #2489#2494#2482#2472#2494#2455#2494#2470
    TabOrder = 3
    object ChkUpdate: TCheckBox
      Left = 19
      Top = 25
      Width = 400
      Height = 17
      Caption = #2437#2477#2495#2471#2494#2472' '#2458#2494#2482#2497#2480' '#2488#2478#2527' '#2488#2527#2434#2453#2509#2480#2495#2527' '#2489#2494#2482#2472#2494#2455#2494#2470' '#2474#2480#2496#2453#2509#2487#2494' '#2453#2480#2476#2503
      TabOrder = 0
    end
    object pnlCheckUpdate: TPanel
      Left = 95
      Top = 65
      Width = 250
      Height = 30
      Cursor = crHandPoint
      Hint = 'Check Update Now'
      BevelOuter = bvNone
      Caption = #2447#2454#2472#2439' '#2489#2494#2482#2472#2494#2455#2494#2470' '#2474#2480#2496#2453#2509#2487#2494' '#2453#2480#2497#2472
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = pnlCheckUpdateClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
  end
  object GroupBox3: TGroupBox
    Left = 9
    Top = 248
    Width = 433
    Height = 98
    Caption = #2465#2503#2463#2494#2476#2503#2460' '#2480#2474#2509#2468#2494#2472#2495'/'#2438#2478#2470#2494#2472#2495
    TabOrder = 4
    object Label3: TLabel
      Left = 9
      Top = 75
      Width = 349
      Height = 15
      Caption = 
        #2470#2509#2480#2487#2509#2463#2476#2509#2479#2435' '#2486#2497#2471#2497#2478#2494#2468#2509#2480' '#2472#2468#2497#2472' '#2447#2476#2434' '#2488#2478#2509#2474#2494#2470#2495#2468' '#2437#2472#2509#2468#2480#2509#2477#2497#2453#2509#2468#2495' '#2488#2478#2498#2489' '#2480#2474#2509#2468#2494#2472#2495 +
        ' '#2453#2480#2494' '#2479#2494#2476#2503#2404
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentFont = False
    end
    object pnlBtnExport: TPanel
      Left = 14
      Top = 29
      Width = 200
      Height = 30
      Cursor = crHandPoint
      Hint = 'Export to a File'
      BevelOuter = bvNone
      Caption = #2475#2494#2439#2482' '#2447' '#2480#2474#2509#2468#2494#2472#2495' '#2453#2480#2497#2472
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = pnlBtnExportClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
    object pnlBtnImport: TPanel
      Left = 220
      Top = 29
      Width = 200
      Height = 30
      Cursor = crHandPoint
      Hint = 'Import from a File'
      BevelOuter = bvNone
      Caption = #2475#2494#2439#2482' '#2469#2503#2453#2503' '#2438#2478#2470#2494#2472#2495' '#2453#2480#2497#2472
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Nirmala UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = pnlBtnImportClick
      OnMouseDown = pnlBtnMouseDown
      OnMouseEnter = pnlBtnMouseEnter
      OnMouseLeave = pnlBtnMouseLeave
      OnMouseUp = pnlBtnMouseUp
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'sodb'
    Filter = 'Shadhin Ovidhan DB|*.sodb'
    Options = [ofPathMustExist, ofFileMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 328
    Top = 296
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'sodb'
    Filter = 'Shadhin Ovidhan DB|*.sodb'
    Options = [ofPathMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 392
    Top = 296
  end
end
