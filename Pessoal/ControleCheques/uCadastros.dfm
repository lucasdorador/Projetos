object FCadastros: TFCadastros
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '[DF SISTEMAS] - Cadastros'
  ClientHeight = 421
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 476
    Height = 126
    ActivePage = tsConta
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object tsBancos: TTabSheet
      Caption = 'Cadastro de Bancos'
      object Label1: TLabel
        Left = 25
        Top = 6
        Width = 43
        Height = 16
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 103
        Top = 6
        Width = 63
        Height = 16
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodBancos: TEdit
        Left = 25
        Top = 24
        Width = 72
        Height = 21
        MaxLength = 10
        TabOrder = 0
      end
      object edtDescricaoBancos: TEdit
        Left = 103
        Top = 24
        Width = 338
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
      end
    end
    object tsConta: TTabSheet
      Caption = 'Cadastros de Contas Correntes'
      ImageIndex = 1
      object Label3: TLabel
        Left = 3
        Top = 6
        Width = 39
        Height = 16
        Caption = 'Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 3
        Top = 49
        Width = 63
        Height = 16
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 206
        Top = 6
        Width = 100
        Height = 16
        Caption = 'Conta Corrente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 120
        Top = 6
        Width = 52
        Height = 16
        Caption = 'Ag'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtBancoContaCorrente: TEdit
        Left = 3
        Top = 24
        Width = 72
        Height = 21
        MaxLength = 10
        TabOrder = 0
      end
      object edtDescricaoConta: TEdit
        Left = 3
        Top = 67
        Width = 454
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 3
      end
      object edtContaCorrente: TEdit
        Left = 206
        Top = 24
        Width = 130
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 15
        TabOrder = 2
      end
      object edtAgenciaConta: TEdit
        Left = 120
        Top = 24
        Width = 80
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 1
      end
      object btnCons_Bancos: TBitBtn
        Left = 81
        Top = 22
        Width = 33
        Height = 25
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000120B0000120B00000000000000000000FFFFFFF8F8F8
          CFCFD0C1C1C2E5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8D0D0D0C2C2C2E5E5E5FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEBEC
          5353743B3B669B9BAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4
          E4C8C8CDE2E2E2FFFFFEFFFFFFECECEC6E6E6E5E5E5EA7A7A7FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4CCCCCCE2E2E2FEFEFECECECFACACAE
          4949754747837B7B8ECBCBC9DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE7A7A
          A660609C8989AFE2E2E2CFCFCFADADAD6D6D6D7878788A8A8ACACACADDDDDDFF
          FFFFFFFFFFFFFFFFFFFFFFDEDEDE9D9D9D909090A6A6A6EDEDED57577944446C
          48487750508540406943436D9797A6FFFFFFFFFFFFFEFEFDD9D9D97A7AA66262
          A19B9BC48484B7CFCFD57575746262626E6E6E7B7B7B616161656565A3A3A3FF
          FFFFFFFFFFFDFDFDD9D9D99D9D9D959595BBBBBBA9A9A9ECECEC585881626294
          5656854949776262916565966A6A7CB6B6B5E3E3E2D1D1D17575A36161A0A1A1
          C6BFBFD89D9DC5E1E1E27C7C7B8787877B7B7B6E6E6E8888888C8C8C797979B4
          B4B4E2E2E2D2D2D29A9A9A949494C0C0C0D3D3D3B9B9B9F9F9F9AFAFBD9292A4
          6464896D6D984C4C7145456F3B3B6343436D747382938F8C7D7AA09B9DC5BEBE
          D89D9DC3F4F4F8FEFEFDBABABA9F9F9F8181819090906A6A6A6767675C5C5C65
          65657F7F7F8E8E8E9A9A9ABDBDBDD3D3D3BBBBBBF7F7F7FFFFFFFFFFFFF0F0F0
          7273918788A84848704D4D7E5F5F8E5B5C905E576FA39E99CAC7C0D1D0DD9C9C
          C2F5F5F8FFFFFFFFFFFFFFFFFFF0F0F08C8C8CA2A2A268686875757585858586
          86866B6B6B9C9C9CC4C4C4DCDCDCBBBBBBF7F7F7FFFFFFFFFFFFFFFFFFD2D2D3
          756F7F978FA16160856969966565858988A6AFABBA9C9895CFCECBC9C4C3F5F5
          F5FFFFFFFFFFFFFFFFFFFFFFFFD3D3D37D7D7D9E9E9E7E7E7E8D8D8D7E7E7EA0
          A0A0B7B7B7979797CDCDCDC6C6C6F6F6F6FFFFFFFFFFFFFFFFFFF7F7F79A999C
          D0CECFC4C2D76A6A8A8080A18484A1CACAE4CBCCE1C9C9CAA5A3A3F3F3F3FFFF
          FFFFFFFFFFFFFFFFFFFFF7F7F79B9B9BCFCFCFD3D3D38484849B9B9B9B9B9BDE
          DEDEDDDDDDC9C9C9A4A4A4F3F3F3FFFFFFFFFFFFFFFFFFFFFFFFE1E1E2A7A5A6
          D4D6E5A8A8CA8585A180809CA9A9C7CCCCE0AAAACCD2D3E3A5A4A4E1E0E1FFFF
          FFFFFFFFFFFFFFFFFFFFE0E0E0A6A6A6E1E1E1C3C3C39B9B9B979797C2C2C2DC
          DCDCC6C6C6E0E0E0A4A4A4E1E1E1FFFFFFFFFFFFFFFFFFFFFFFFDDDDDCC1C1BE
          C0C2DCBCBCD7C9C9E0C3C3DDC1C1DAC1C1D9ACACCCBEC0DCC2C1BEDBDBDAFFFF
          FFFFFFFFFFFFFFFFFFFFDBDBDBBFBFBFD7D7D7D2D2D2DCDCDCD8D8D8D5D5D5D4
          D4D4C6C6C6D6D6D6BFBFBFDBDBDBFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEC6C6C2
          BCBEDBCBCBDFCBCBE0C1C1DAB9B9D4B3B3D1A0A0C6B9BBDAC7C7C3DDDDDCFFFF
          FFFFFFFFFFFFFFFFFFFFDDDDDDC3C3C3D5D5D5DBDBDBDCDCDCD5D5D5CFCFCFCB
          CBCBBEBEBED3D3D3C3C3C3DDDDDDFFFFFFFFFFFFFFFFFFFFFFFFECECEDB7B6B7
          D2D3E6BBBBD6E3E3EECCCCE0C0C0D9B2B2D08585B5D3D4E7B8B7B7EBEBECFFFF
          FFFFFFFFFFFFFFFFFFFFECECECB7B7B7E1E1E1D1D1D1ECECECDCDCDCD4D4D4CA
          CACAACACACE3E3E3B7B7B7ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDBCBF
          D9D9D9B9B9D8B6B6D3C8C8DBB7B7D19292BCADAED0DBDADABDBCC0FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFD9D9D9D2D2D2CECECED7D7D7CCCCCCB4
          B4B4CACACADADADABFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F5
          B5B4B4DADADBD0D0E3B8B8D0B6B6D0D2D3E4DDDDDDB5B3B4F4F4F5FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4B4B4B4DBDBDBDFDFDFCBCBCBCACACAE0
          E0E0DDDDDDB4B4B4F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F7F7F8C7C7C9BFBEC0CECDC9CFCECAC0BFC0C7C7C9F7F7F8FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8C9C9C9BFBFBFCBCBCBCBCBCBBF
          BFBFC9C9C9F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        NumGlyphs = 2
        TabOrder = 4
        TabStop = False
        OnClick = btnCons_BancosClick
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 362
    Width = 476
    Height = 56
    Align = alBottom
    BevelWidth = 2
    TabOrder = 2
    object btnGravar: TBitBtn
      Left = 6
      Top = 8
      Width = 150
      Height = 41
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnExcluir: TBitBtn
      Left = 162
      Top = 8
      Width = 150
      Height = 41
      Caption = 'Excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnExcluirClick
    end
    object btnSair: TBitBtn
      Left = 318
      Top = 8
      Width = 150
      Height = 41
      Caption = 'Sair'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnSairClick
    end
  end
  object dbCadastros: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 135
    Width = 476
    Height = 221
    TabStop = False
    Align = alBottom
    DataSource = DSCadastros
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbCadastrosDblClick
  end
  object DSCadastros: TDataSource
    DataSet = FDCadastros
    Left = 183
    Top = 147
  end
  object FDCadastros: TFDQuery
    Left = 271
    Top = 147
  end
end
