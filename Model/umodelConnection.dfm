object modelConnection: TmodelConnection
  Height = 244
  Width = 221
  object cnMontreal: TFDConnection
    Params.Strings = (
      'Database=C:\BrunoGoncalves\Montreal-BDMG\Data\MONTREAL.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=fB')
    Left = 80
    Top = 128
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 88
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = cnMontreal
    Left = 88
    Top = 192
  end
end
