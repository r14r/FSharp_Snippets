## blob-storage.fsx
```
open System
open System.IO
open Azure.Storage.Blobs // Namespace for Blob storage types
open Azure.Storage.Blobs.Models
open Azure.Storage.Blobs.Specialized
open System.Text

//
// Switch to the source directory that this is used implicitly when interacting with the File object.
//

System.Environment.CurrentDirectory <- __SOURCE_DIRECTORY__

//
// Get your connection string.
//

let storageConnString = "..." // fill this in from your storage account

//
// Create some local dummy data.
//

// Create a dummy file to upload
let localFile = "./myfile.txt"
File.WriteAllText(localFile, "some data")

//
// Create a container.
//

 // Create a blob container client.
let container = BlobContainerClient(storageConnString, "myContainer")

// Create the container if it doesn't already exist.
container.CreateIfNotExists()

let permissions = PublicAccessType.Blob
container.SetAccessPolicy(permissions)

//
// Upload a blob into a container.
//

// Retrieve reference to a blob named "myblob.txt".
let blockBlob = container.GetBlobClient("myblob.txt")

// Create or overwrite the "myblob.txt" blob with contents from the local file.
use fileStream = new FileStream(localFile, FileMode.Open, FileAccess.Read, FileShare.Read)
do blockBlob.Upload(fileStream)

//
// List the blobs in a container.
//

// Loop over items within the container and output the name.
for item in container.GetBlobsByHierarchy() do
    printfn $"Blob name: {item.Blob.Name}"

//
// Download Blobs.
//

// Retrieve reference to a blob named "myblob.txt".
let blobToDownload = container.GetBlobClient("myblob.txt")

// Save blob contents to a file.
do
    use fileStream = File.OpenWrite("path/download.txt")
    blobToDownload.DownloadTo(fileStream)

let text = blobToDownload.DownloadContent().Value.Content.ToString()

//
// Delete blobs.
//

// Retrieve reference to a blob named "myblob.txt".
let blobToDelete = container.GetBlobClient("myblob.txt")

// Delete the blob.
blobToDelete.Delete()

//
// List blobs in pages asynchronously
//

let ListBlobsSegmentedInHierarchicalListing(container:BlobContainerClient) =
        // List blobs to the console window, with paging.
        printfn "List blobs in pages:"

        // Call GetBlobsByHierarchy to return an async collection 
        // of blobs in this container. AsPages() method enumerate the values 
        //a Page<T> at a time. This may make multiple service requests.

        for page in container.GetBlobsByHierarchy().AsPages() do
            for blobHierarchyItem in page.Values do 
                printf $"The BlobItem is : {blobHierarchyItem.Blob.Name} "

        printfn ""


// Create some dummy data by uploading the same file over and over again
for i in 1 .. 100 do
    let blob  = container.GetBlobClient($"myblob{i}.txt")
    use fileStream = System.IO.File.OpenRead(localFile)
    blob.Upload(localFile)

ListBlobsSegmentedInHierarchicalListing container

//
// Writing to an append blob.
//

// Get a reference to a container.
let appendContainer = BlobContainerClient(storageConnString, "my-append-blobs")

// Create the container if it does not already exist.
appendContainer.CreateIfNotExists() |> ignore

// Get a reference to an append blob.
let appendBlob = appendContainer.GetAppendBlobClient("append-blob.log")

// Create the append blob. Note that if the blob already exists, the 
// CreateOrReplace() method will overwrite it. You can check whether the 
// blob exists to avoid overwriting it by using CloudAppendBlob.Exists().
appendBlob.CreateIfNotExists()

let numBlocks = 10

// Generate an array of random bytes.
let rnd = Random()
let bytesArray = Array.zeroCreate<byte>(numBlocks)
rnd.NextBytes(bytesArray)

// Simulate a logging operation by writing text data and byte data to the 
// end of the append blob.
for i in 0 .. numBlocks - 1 do
    let msg = sprintf $"Timestamp: {DateTime.UtcNow} \tLog Entry: {bytesArray.[i]}\n"
    let array = Encoding.ASCII.GetBytes(msg);
    use stream = new MemoryStream(array)
    appendBlob.AppendBlock(stream)

// Read the append blob to the console window.
let downloadedText = appendBlob.DownloadContent().ToString()
printfn $"{downloadedText}"
```

## file-storage.fsx
```
open System
open System.IO
open Azure
open Azure.Storage // Namespace for StorageSharedKeyCredential
open Azure.Storage.Blobs // Namespace for BlobContainerClient
open Azure.Storage.Sas // Namespace for ShareSasBuilder
open Azure.Storage.Files.Shares // Namespace for File storage types
open Azure.Storage.Files.Shares.Models // Namespace for ShareServiceProperties

//
// Get your connection string.
//

let storageConnString = "..." // fill this in from your storage account

//
// Create the File service client.
//

let share = ShareClient(storageConnString, "shareName")

//
// Create a file share.
//

share.CreateIfNotExistsAsync()

//
// Create a directory
//

// Get a reference to the directory
let directory = share.GetDirectoryClient("directoryName")

// Create the directory if it doesn't already exist
directory.CreateIfNotExistsAsync()

//
// Upload a file to the sample directory
//

let file = directory.GetFileClient("fileName")

let writeToFile localFilePath = 
    use stream = File.OpenRead(localFilePath)
    file.Create(stream.Length)
    file.UploadRange(
        HttpRange(0L, stream.Length),
        stream)

writeToFile "localFilePath"

//
// Download a file to a local file
//

let download = file.Download()

let copyTo saveDownloadPath = 
    use downStream = File.OpenWrite(saveDownloadPath)
    download.Value.Content.CopyTo(downStream)

copyTo "Save_Download_Path"

//
// Set the maximum size for a file share.
//

// stats.Usage is current usage in GB
let ONE_GIBIBYTE = 10_737_420_000L // Number of bytes in 1 gibibyte
let stats = share.GetStatistics().Value
let currentGiB = int (stats.ShareUsageInBytes / ONE_GIBIBYTE)

// Set the quota to 10 GB plus current usage
share.SetQuotaAsync(currentGiB + 10)

// Remove the quota
share.SetQuotaAsync(0)

//
// Generate a shared access signature for a file or file share.
//

let accountName = "..." // Input your storage account name
let accountKey = "..." // Input your storage account key

// Create a 24-hour read/write policy.
let expiration = DateTimeOffset.UtcNow.AddHours(24.)
let fileSAS = ShareSasBuilder(
      ShareName = "shareName",
      FilePath = "filePath",
      Resource = "f",
      ExpiresOn = expiration)

// Set the permissions for the SAS
let permissions = ShareFileSasPermissions.All
fileSAS.SetPermissions(permissions)

// Create a SharedKeyCredential that we can use to sign the SAS token
let credential = StorageSharedKeyCredential(accountName, accountKey)

// Build a SAS URI
let fileSasUri = UriBuilder($"https://{accountName}.file.core.windows.net/{fileSAS.ShareName}/{fileSAS.FilePath}")
fileSasUri.Query = fileSAS.ToSasQueryParameters(credential).ToString()

//
// Copy a file to another file.
//
let sourceFile = ShareFileClient(storageConnString, "shareName", "sourceFilePath")
let destFile = ShareFileClient(storageConnString, "shareName", "destFilePath")
destFile.StartCopyAsync(sourceFile.Uri)

//
// Copy a file to a blob.
//

// Create a new file SAS 
let fileSASCopyToBlob = ShareSasBuilder(
    ShareName = "shareName",
    FilePath = "sourceFilePath",
    Resource = "f",
    ExpiresOn = DateTimeOffset.UtcNow.AddHours(24.))
let permissionsCopyToBlob = ShareFileSasPermissions.Read
fileSASCopyToBlob.SetPermissions(permissionsCopyToBlob)
let fileSasUriCopyToBlob = UriBuilder($"https://{accountName}.file.core.windows.net/{fileSASCopyToBlob.ShareName}/{fileSASCopyToBlob.FilePath}")

// Get a reference to the file.
let sourceFileCopyToBlob = ShareFileClient(fileSasUriCopyToBlob.Uri)

// Get a reference to the blob to which the file will be copied.
let containerCopyToBlob = BlobContainerClient(storageConnString, "containerName");
containerCopyToBlob.CreateIfNotExists()
let destBlob = containerCopyToBlob.GetBlobClient("blobName")
destBlob.StartCopyFromUriAsync(sourceFileCopyToBlob.Uri)

//
// Troubleshooting File storage using metrics.
//

// Instatiate a ShareServiceClient
let shareService = ShareServiceClient(storageConnString);

// Set metrics properties for File service
let props = ShareServiceProperties()

props.HourMetrics = ShareMetrics(
    Enabled = true,
    IncludeApis = true,
    Version = "1.0",
    RetentionPolicy = ShareRetentionPolicy(Enabled = true,Days = 14))

props.MinuteMetrics = ShareMetrics(
    Enabled = true,
    IncludeApis = true,
    Version = "1.0",
    RetentionPolicy = ShareRetentionPolicy(Enabled = true,Days = 7))

shareService.SetPropertiesAsync(props)
```

## queue-storage.fsx
```
open Azure.Storage.Queues // Namespace for Queue storage types
open System
open System.Text

//
// Get your connection string.
//

let storageConnString = "..." // fill this in from your storage account

//
// Create the Queue Service client.
//

let queueClient = QueueClient(storageConnString, "myqueue")

//
// Create a queue.
//

queueClient.CreateIfNotExists()

//
// Insert a message into a queue.
//

queueClient.SendMessage("Hello, World") // Insert a String message into a queue
queueClient.SendMessage(BinaryData.FromBytes(Encoding.UTF8.GetBytes("Hello, World"))) // Insert a BinaryData message into a queue

//
// Peek at the next message.
//

let peekedMessage = queueClient.PeekMessage()
let messageContents = peekedMessage.Value.Body.ToString()

//
// Get the next message.
//

let updateMessage = queueClient.ReceiveMessage().Value

//
// Change the contents of a retrieved message.
//

queueClient.UpdateMessage(
    updateMessage.MessageId,
    updateMessage.PopReceipt,
    "Updated contents.",
    TimeSpan.FromSeconds(60.0))

//
// De-queue the next message, indicating successful processing
//

let deleteMessage = queueClient.ReceiveMessage().Value
queueClient.DeleteMessage(deleteMessage.MessageId, deleteMessage.PopReceipt)

//
// Use Async-Await pattern with common Queue storage APIs.
//

async {
    let! exists = queueClient.CreateIfNotExistsAsync() |> Async.AwaitTask

    let! delAsyncMessage = queueClient.ReceiveMessageAsync() |> Async.AwaitTask

    // ... process the message here ...

    // Now indicate successful processing:
    queueClient.DeleteMessageAsync(delAsyncMessage.Value.MessageId, delAsyncMessage.Value.PopReceipt) |> Async.AwaitTask
}

//
// Additional options for de-queuing messages.
//

for dequeueMessage in queueClient.ReceiveMessages(20, Nullable(TimeSpan.FromMinutes(5.))).Value do
        // Process the message here.
        queueClient.DeleteMessage(dequeueMessage.MessageId, dequeueMessage.PopReceipt)

//
// Get the queue length.
//

let properties = queueClient.GetProperties().Value
let count = properties.ApproximateMessagesCount

//
// Delete a queue.
//

queueClient.DeleteIfExists()
```

## table-storage.fsx
```
// <nuget>
#r "nuget:Azure.Data.Tables" // Load the Azure Data Tables nuget package
// </nuget>

// <open>
open System
open Azure
open Azure.Data.Tables // Namespace for Table storage types
// </open>

//
// Get your connection string.
//
// <connectionString>
let storageConnString = "UseDevelopmentStorage=true" // fill this in from your storage account
// </connectionString>

//
// Create the Table service client.
//
// <createTableClient>
let tableClient = TableServiceClient storageConnString
// </createTableClient>

//
// Create a table.
//
// <createTable>
// Retrieve a reference to the table.
let table = tableClient.GetTableClient "people"

// Create the table if it doesn't exist.
table.CreateIfNotExists () |> ignore
// </createTable>

//
// Add an entity to a table. The last name is used as a partition key.
//

// Note: In F#, interfaces are implemented explicitly. The Azure Storage SDK
// expects at least PartitionKey and RowKey to be implicitly available. Therefore,
// we have to "shadow" both PartitionKey and RowKey on the Customer type directly.
// <addEntity>
type Customer (firstName, lastName, email: string, phone: string) =
    interface ITableEntity with
        member val ETag = ETag "" with get, set
        member val PartitionKey = "" with get, set
        member val RowKey = "" with get, set
        member val Timestamp = Nullable() with get, set

    new() = Customer(null, null, null, null)
    member val Email = email with get, set
    member val PhoneNumber = phone with get, set
    member val PartitionKey = lastName with get, set
    member val RowKey = firstName with get, set
// </addEntity>

// <addEntityToTable>
let customer = Customer ("Walter", "Harp", "Walter@contoso.com", "425-555-0101")
table.AddEntity customer
// </addEntityToTable>

//
// Insert a batch of entities. All must have the same partition key.
//
// <addBatchOfEntities>
let customers =
    [
        Customer("Jeff", "Smith", "Jeff@contoso.com", "425-555-0102")
        Customer("Ben", "Smith", "Ben@contoso.com", "425-555-0103")
    ]

// Add the entities to be added to the batch and submit it in a transaction.
customers
|> List.map (fun customer -> TableTransactionAction (TableTransactionActionType.Add, customer))
|> table.SubmitTransaction
// </addBatchOfEntities>

//
// Retrieve all entities in a partition.
//
// <retrieveEntities>
table.Query<Customer> "PartitionKey eq 'Smith'"
// </retrieveEntities>

//
// Retrieve a range of entities in a partition.
//
// <retrieveEntitiesRange>
table.Query<Customer> "PartitionKey eq 'Smith' and RowKey lt 'J'"
// </retrieveEntitiesRange>

//
// Retrieve a single entity.
//
// <retrieveEntity>
let singleResult = table.GetEntity<Customer>("Smith", "Ben").Value
// </retrieveEntity>

// <printEntity>
// Evaluate this value to print it out into the F# Interactive console
singleResult
// </printEntity>

//
// Update an entity and show how to handle any exceptions that Azure may throw.
//
// <updateEntity>
singleResult.PhoneNumber <- "425-555-0103"
try
    table.UpdateEntity (singleResult, ETag "", TableUpdateMode.Replace) |> ignore
    printfn "Update succeeded"
with
| :? RequestFailedException as e ->
    printfn $"Update failed: {e.Status} - {e.ErrorCode}"
// </updateEntity>

//
// Upsert an entity.
//
// <upsertEntity>
singleResult.PhoneNumber <- "425-555-0104"
table.UpsertEntity (singleResult, TableUpdateMode.Replace)
// </upsertEntity>

//
// Query a subset of entity properties.
//
// <querySubset>
query {
    for customer in table.Query<Customer> () do
    select customer.Email
}
// </querySubset>

//
// Retrieve entities in pages asynchronously.
//
// <retrieveEntitiesAsync>
let pagesResults = table.Query<Customer> ()

for page in pagesResults.AsPages () do
    printfn "This is a new page!"
    for customer in page.Values do
        printfn $"customer: {customer.RowKey} {customer.PartitionKey}"
// </retrieveEntitiesAsync>

//
// Delete an entity.
//
// <deleteEntity>
table.DeleteEntity ("Smith", "Ben")
// </deleteEntity>

//
// Delete a table.
//
// <deleteTable>
table.Delete ()
// </deleteTable>
```

