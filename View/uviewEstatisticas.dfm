object viewEstatisticas: TviewEstatisticas
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Estat'#237'ticas das Tarefas'
  ClientHeight = 124
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblResultado: TLabel
    Left = 8
    Top = 69
    Width = 55
    Height = 15
    Caption = 'Resultado'
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 353
    DesignSize = (
      452
      57)
    object btnMedia: TButton
      Left = 120
      Top = 7
      Width = 97
      Height = 44
      Caption = 'M'#233'dia (Pendentes)'
      TabOrder = 1
      WordWrap = True
      OnClick = btnMediaClick
    end
    object btnConcluidas: TButton
      Left = 233
      Top = 7
      Width = 97
      Height = 44
      Caption = 'Conclu'#237'das ('#218'ltimos 7 dias)'
      TabOrder = 2
      WordWrap = True
      OnClick = btnConcluidasClick
    end
    object btnTotal: TButton
      Left = 8
      Top = 7
      Width = 97
      Height = 44
      Caption = 'Total de Tarefas'
      TabOrder = 0
      OnClick = btnTotalClick
    end
    object btnCancelar: TButton
      Left = 345
      Top = 7
      Width = 97
      Height = 44
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 3
      WordWrap = True
      OnClick = btnCancelarClick
      ExplicitLeft = 357
    end
  end
  object edtResultado: TEdit
    Left = 8
    Top = 86
    Width = 434
    Height = 23
    MaxLength = 100
    TabOrder = 1
  end
end
