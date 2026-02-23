abstract class InterfaceRepository<T> {
  // fetch all data from db
  Future<T?> fetchAll();

  // insert data to db
  Future<void> insertItem({required T data});

  // is data exist in db
  Future<bool> isDataExist();

}